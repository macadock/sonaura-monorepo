create table pages (
                       id uuid primary key not null default gen_random_uuid(),
                       title text not null,
                       slug text not null UNIQUE,
                       content jsonb not null default '[]'::jsonb,
                       created_at timestamp with time zone not null default now(),
                       updated_at timestamp with time zone not null default now()
);

create trigger update_pages_updated_at
    before update on pages
    for each row
execute function update_updated_at_column();