alter table public.pages enable row level security;

create index  pages_slug_index on public.pages (slug);

create policy "Allow public read access"
    on public.pages
    for select
    using
    ( true );

create policy "Allow all access to admin and editors"
    on public.pages
    for all
    using
    ( public.is_admin_authenticated_user() OR public.is_editor_authenticated_user() )
    with check
    ( public.is_admin_authenticated_user() OR public.is_editor_authenticated_user() );
