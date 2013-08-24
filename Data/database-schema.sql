/* 1. Remove any existing structure, and just rebuild the schema cleanly */
drop table if exists employeee cascade;
drop table if exists project_contact cascade;
drop table if exists person cascade;
drop table if exists project cascade;
drop sequence if exists person_seq;
drop sequence if exists project_seq;

/* 2. Create Sequences */
create sequence person_seq start 1;
create sequence project_seq start 1;

/* 3. Create tables */
create table person (
	id int not null primary key default nextval('person_seq'),
	last_name varchar(100) not null,
	first_name varchar(100) not null
);

create table project (
	id int not null primary key default nextval('project_seq'),
	name varchar(200) not null,
	start_date date not null default CURRENT_DATE,
	end_date date
);

create table project_contact (
	project_id int not null,
	person_id int not null,
	title varchar(50),
	is_active boolean not null default true
);

create table employee (
	person_id int not null primary key,
	title varchar(50) not null,
	hire_date date not null,
	termination_date date,
	active boolean not null default true
);

/* 4. Add keys */
alter table employee add constraint "employee_person_person_id_fk" foreign key (person_id) references person(id);
alter table project_contact add primary key (project_id, person_id);
alter table project_contact add constraint "project_contact_project_project_id_fk" foreign key (project_id) references project(id);
alter table project_contact add constraint "project_contact_person_person_id_fk" foreign key (person_id) references person(id);

/* 5. Grant privileges */
grant all privileges on table person to wwwrun;
grant all privileges on table project to wwwrun;
grant all privileges on table project_contact to wwwrun;
grant all privileges on table employee to wwwrun;

/* 6. Populate base data */
insert into person (first_name, last_name) values ('Ben', 'Chesnut');
insert into person (first_name, last_name) values ('Geoff', 'Baker');
insert into person (first_name, last_name) values ('Jeff', 'Hanson');
insert into person (first_name, last_name) values ('Tony', 'Newcome');

insert into project (name, start_date, end_date) values ('Internationalization', '12/19/2011', '7/1/2012');
insert into project (name, start_date) values ('Contacts-Metadata', '7/1/2012');

insert into project_contact (project_id, person_id, title, is_active) values(1,4,'Sr. Manager', false);
insert into project_contact (project_id, person_id, title) values(2,2,'Principal Engineer');
insert into project_contact (project_id, person_id, title) values(2,3,'Manager');
insert into project_contact (project_id, person_id, title) values(2,4,'Director');

insert into employee (person_id, title, hire_date) values(1, 'Architect', '8/15/2011');