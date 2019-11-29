DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS owners;

CREATE TABLE owners (
	owner_id SERIAL PRIMARY KEY,
	name VARCHAR,
	address VARCHAR,
	preference VARCHAR
);

CREATE TABLE animals (
	animal_id SERIAL PRIMARY KEY,
	name VARCHAR,
	breed VARCHAR,
	trained BOOLEAN,
	admission_date DATE,
	owner_id INT REFERENCES owners(owner_id)
);

INSERT INTO owners (name, address, preference) VALUES ('Shelter', 'Shelter Address', 'All');
