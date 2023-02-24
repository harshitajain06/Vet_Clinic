SELECT * from animals WHERE name like '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = TRUE;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
select * from animals;
ROLLBACK;

BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
Update animals SET species = 'pokemon' WHERE species IS NULL;
commit;

select * from animals;

BEGIN TRANSACTION;
DELETE FROM animals;
select * from animals;
ROLLBACK;

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
select * from animals;
SAVEPOINT t;

UPDATE animals SET weight_kg = weight_kg * -1;
select * from animals;
ROLLBACK TO t;
select * from animals;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
select * from animals;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth 
BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;


SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';
SELECT * FROM animals a INNER JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';
SELECT * FROM owners o FULL OUTER JOIN animals a ON o.id = a.owner_id;
SELECT s.name, COUNT(*) FROM species s LEFT JOIN animals a ON s.id =  a.species_id GROUP BY s.name;
SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Jennifer Orwell' AND a.species_id = (SELECT id from species WHERE name = 'Digimon');
SELECT * FROM animals a INNER JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts <= 0;
SELECT o.full_name, COUNT(*) FROM owners o LEFT JOIN animals a ON o.id =  a.owner_id GROUP BY o.full_name ORDER BY COUNT DESC LIMIT 1;

SELECT a.* FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vet ON vet.id = v.vet_id WHERE vet.name = 'William Tatcher' ORDER BY v.visit_date DESC LIMIT 1;

SELECT COUNT(DISTINCT a.id) as num_animals FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vet ON vet.id = v.vet_id WHERE vet.name = 'Stephanie Mendez';

SELECT vets.name, COALESCE(array_to_string(array_agg(s.name), ', '), 'none') AS specialties FROM vets LEFT JOIN specializations sp ON vets.id = sp.vet_id LEFT JOIN species s ON sp.species_id = s.id GROUP BY vets.id;

SELECT a.* FROM animals a JOIN visits v ON a.id = v.animal_id JOIN vets vet ON vet.id = v.vet_id WHERE vet.name = 'Stephanie Mendez' AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name, COUNT(v.*) as num_visits FROM animals a JOIN visits v ON a.id = v.animal_id GROUP BY a.id ORDER BY num_visits DESC LIMIT 1;

SELECT a.name, v.visit_date FROM visits v INNER JOIN animals a ON v.animal_id = a.id WHERE v.vet_id IN (SELECT id FROM vets WHERE name = 'Maisy Smith') ORDER BY v.visit_date ASC LIMIT 1;

SELECT a.name AS animal_name, vt.name AS vet_name, v.visit_date FROM animals a INNER JOIN visits v ON a.id = v.animal_id INNER JOIN vets vt ON v.vet_id = vt.id WHERE v.visit_date = (SELECT MAX(visit_date) FROM visits);

SELECT COUNT(*) AS num_visits FROM visits v INNER JOIN vets vt ON v.vet_id = vt.id INNER JOIN animals a ON v.animal_id = a.id LEFT JOIN specializations sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id WHERE sp.species_id IS NULL;


SELECT s.name FROM animals a INNER JOIN visits v ON a.id = v.animal_id INNER JOIN species s ON a.species_id = s.id WHERE v.vet_id IN (SELECT id FROM vets WHERE name ILIKE '%maisy smith%') GROUP BY s.id ORDER BY COUNT(*) DESC LIMIT 1;