/* 1. Remove any existing structure, and just rebuild the schema cleanly */
drop table if exists project_time cascade;
drop table if exists activity_time cascade;
drop table if exists time_entry cascade;
drop table if exists role_type cascade;
drop table if exists employee_project cascade;
drop table if exists activity_type cascade;
drop table if exists activity cascade;
drop table if exists employee cascade;
drop table if exists project_contact cascade;
drop table if exists person cascade;
drop table if exists project cascade;
drop sequence if exists person_seq;
drop sequence if exists project_seq;
drop sequence if exists employee_seq;
drop sequence if exists employee_project_seq;
drop sequence if exists activity_seq;
drop sequence if exists role_type_seq;
drop sequence if exists time_entry_seq;
drop sequence if exists activity_type_seq;

/* 2. Create Sequences */
create sequence person_seq start 1;
create sequence project_seq start 1;
create sequence employee_seq start 1;
create sequence employee_project_seq start 1;
create sequence activity_seq start 1;
create sequence role_type_seq start 1;
create sequence time_entry_seq start 1;
create sequence activity_type_seq start 1;

/* 3. Create tables */
create table person (
	person_id int not null primary key default nextval('person_seq'),
	last_name varchar(100) not null,
	first_name varchar(100) not null
);

create table project (
	project_id int not null primary key default nextval('project_seq'),
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
	employee_id int not null primary key default nextval('employee_seq'),
	person_id int not null,
	title varchar(50) not null,
	hire_date date not null,
	termination_date date,
	is_active boolean not null default true
);

create table activity_type (
	activity_type_id int not null primary key default nextval('activity_type_seq'),
	name varchar(50) not null
);

create table role_type (
	role_type_id int not null primary key default nextval('role_type_seq'),
	name varchar(50) not null
);

create table employee_project(
	employee_project_id int not null primary key default nextval('employee_project_seq'),
	project_id int not null,
	role_type_id int not null,
	employee_id int not null
);

create table time_entry(
	time_entry_id int not null primary key default nextval('time_entry_seq'),
	start_time time not null default CURRENT_TIME,
	end_time time
);

create table activity(
	activity_id int not null primary key default nextval('activity_seq'),
	employee_id int not null,
	activity_type_id int not null,
	summary varchar(200) not null,
	description text
);

create table activity_time(
	activity_id int not null,
	time_entry_id int not null,
	activity_date date not null default CURRENT_DATE
);

create table project_time(
	employee_project_id int not null,
	time_entry_id int not null,
	entry_date date not null default CURRENT_DATE
);

/* 4. Add Additional Primary Keys */
alter table project_contact add primary key (project_id, person_id);
alter table activity_time add primary key (activity_id, time_entry_id);
alter table project_time add primary key (employee_project_id, time_entry_id);

/* 5. Add Foreign Keys */
alter table employee add constraint "employee_person_person_id_fk" foreign key (person_id) references person(person_id);
alter table project_contact add constraint "project_contact_project_project_id_fk" foreign key (project_id) references project(project_id);
alter table project_contact add constraint "project_contact_person_person_id_fk" foreign key (person_id) references person(person_id);
alter table employee_project add constraint "employee_project_employee_employee_id_fk" foreign key (employee_id) references employee(employee_id);
alter table employee_project add constraint "employee_project_project_project_id_fk" foreign key (project_id) references project(project_id);
alter table employee_project add constraint "employee_project_role_type_role_type_id_fk" foreign key (role_type_id) references role_type(role_type_id);
alter table activity add constraint "activity_employee_employee_id_fk" foreign key (employee_id) references employee(employee_id);
alter table activity add constraint "activity_activity_type_activity_type_id_fk" foreign key (activity_type_id) references activity_type(activity_type_id);
alter table activity_time add constraint "activity_time_activity_activity_id_fk" foreign key (activity_id) references activity(activity_id);
alter table activity_time add constraint "activity_time_time_entry_time_entry_id_fk" foreign key (time_entry_id) references time_entry(time_entry_id);
alter table project_time add constraint "project_time_employee_project_employee_project_id_fk" foreign key (employee_project_id) references employee_project(employee_project_id);
alter table project_time add constraint "project_time_time_entry_time_entry_id_fk" foreign key (time_entry_id) references time_entry(time_entry_id);

/* 6. Grant privileges */
grant all privileges on table person to wwwrun;
grant all privileges on table project to wwwrun;
grant all privileges on table project_contact to wwwrun;
grant all privileges on table employee to wwwrun;
grant all privileges on table activity_type to wwwrun;
grant all privileges on table role_type to wwwrun;
grant all privileges on table employee_project to wwwrun;
grant all privileges on table time_entry to wwwrun;
grant all privileges on table activity to wwwrun;
grant all privileges on table activity_time to wwwrun;
grant all privileges on table project_time to wwwrun;

/* 7. Populate base data */
insert into role_type (name) values('Developer');
insert into role_type (name) values('Sr. Developer');
insert into role_type (name) values('Business Analyst');
insert into role_type (name) values('Sr. Business Analyst');
insert into role_type (name) values('QA Analyst');
insert into role_type (name) values('Sr. QA Analyst');
insert into role_type (name) values('Architect');
insert into role_type (name) values('Sr. Architect');
insert into role_type (name) values('Project Manager');
insert into role_type (name) values('Sr. Project Manager');
insert into role_type (name) values('Executive');

insert into activity_type (name) values('Business Development');
insert into activity_type (name) values('Delivery');
insert into activity_type (name) values('Practice Management');

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

insert into employee_project (employee_id, project_id, role_type_id) values (1, 1, 7);
insert into employee_project (employee_id, project_id, role_type_id) values (1, 2, 7);