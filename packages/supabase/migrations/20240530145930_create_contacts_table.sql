create type contacts_status as enum ('NEW', 'IN_PROGRESS', 'CLOSED');

create table
    contacts (
                 id uuid primary key not null default gen_random_uuid(),
                 first_name text not null,
                 last_name text not null,
                 email text not null,
                 phone text not null,
                 message text not null,
                 postal_code text not null,
                 status contacts_status not null default 'NEW',
                 created_at timestamp with time zone not null default now(),
                 updated_at timestamp with time zone not null default now()
) ;

create trigger update_contacts_updated_at
    before update on contacts
    for each row
execute function update_updated_at_column();
