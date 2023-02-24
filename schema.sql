CREATE TABLE animals(id serial primary key,
 name varchar(100), 
 date_of_birth date, 
 escape_attempts int, 
 neutered boolean, 
 weight_kg decimal(20));

alter table animals add column species varchar(20);

CREATE TABLE owners (id SERIAL PRIMARY KEY,full_name TEXT,age INTEGER);
CREATE TABLE species (id SERIAL PRIMARY KEY,name TEXT);
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INTEGER, ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INTEGER, ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners(id);


CREATE TABLE vets (id SERIAL PRIMARY KEY, name TEXT, age INTEGER, date_of_graduation DATE);
CREATE TABLE specializations (vet_id INTEGER, species_id INTEGER, PRIMARY KEY (vet_id, species_id), FOREIGN KEY (vet_id) REFERENCES vets(id), FOREIGN KEY (species_id) REFERENCES species(id));
CREATE TABLE visits (vet_id INTEGER, animal_id INTEGER, visit_date DATE, FOREIGN KEY (vet_id) REFERENCES vets(id), FOREIGN KEY (animal_id) REFERENCES animals(id));