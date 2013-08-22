create sequence if not exists person_seq start 1;
create sequence if not exists project_seq start 1;

create table if not exists person (
	id int not null primary key default nextval('person_seq'),
	last_name varchar(100) not null,
	first_name varchar(100) not null
);

create table if not exists project (
	id int not null primary key default nextval('project_seq'),
	name varchar(200) not null,
	start_date date not null default CURRENT_DATE,
	end_date date
);

create table if not exists project_contact (
	project_id int not null,
	person_id int not null,
	is_active boolean not null default true
);