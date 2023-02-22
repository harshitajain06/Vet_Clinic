CREATE TABLE animals(id serial primary key,
 name varchar(100), 
 date_of_birth date, 
 escape_attempts int, 
 neutered boolean, 
 weight_kg decimal(20));

 alter table animals add column species varchar(20);