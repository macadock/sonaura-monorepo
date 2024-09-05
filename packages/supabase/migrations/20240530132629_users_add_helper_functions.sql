create function is_admin_authenticated_user()
    returns boolean
    language sql
    security definer
    set search_path = public
    stable
as $$
select exists(
    select *
    from users
    where id = auth.uid()
      and role = 'ADMIN'
)
$$;

create function is_editor_authenticated_user()
    returns boolean
    language sql
    security definer
    set search_path = public
    stable
as $$
select exists(
    select *
    from users
    where id = auth.uid()
      and role = 'EDITOR'
)
$$;

create function is_viewer_authenticated_user()
    returns boolean
    language sql
    security definer
    set search_path = public
    stable
as $$
select exists(
    select *
    from users
    where id = auth.uid()
      and role = 'VIEWER'
)
$$;

create function is_visitor_authenticated_user()
    returns boolean
    language sql
    security definer
    set search_path = public
    stable
as $$
select exists(
    select *
    from users
    where id = auth.uid()
      and role = 'VISITOR'
)
$$;
