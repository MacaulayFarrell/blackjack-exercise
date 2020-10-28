drop table if exists solutions CASCADE;
drop table if exists ticket CASCADE;
drop sequence if exists hibernate_sequence;
create sequence hibernate_sequence start with 1 increment by 1;

create table solutions (id bigint not null, solution_desc varchar(255), ticket_id bigint, primary key (id));

create table ticket (id bigint not null, author varchar(255), completed bigint, description varchar(255), time_created timestamp, title varchar(255), topic varchar(255), urgency varchar(255), primary key (id));
