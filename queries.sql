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

