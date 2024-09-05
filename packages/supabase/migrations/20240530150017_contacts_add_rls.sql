alter table public.contacts enable row level security;

create policy "Allow public write access"
    on public.contacts
    for insert
    with check
    ( true );

create policy "Allow all access to admin and editors"
    on public.contacts
    for all
    using
    ( public.is_admin_authenticated_user() OR public.is_editor_authenticated_user() )
    with check
    ( public.is_admin_authenticated_user() OR public.is_editor_authenticated_user() );

