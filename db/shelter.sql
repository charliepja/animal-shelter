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
	owner_id INT DEFAULT 1 REFERENCES owners(owner_id) ON DELETE SET DEFAULT
);

CREATE TABLE training (
	training_plan_id SERIAL PRIMARY KEY,
	toilet_trained BOOLEAN DEFAULT false,
	sit BOOLEAN DEFAULT false,
	stay BOOLEAN DEFAULT false,
	come BOOLEAN DEFAULT false,
	heel BOOLEAN DEFAULT false,
	down BOOLEAN DEFAULT false,
	socialised BOOLEAN DEFAULT false,
	animal_id INT REFERENCES animals(animal_id) ON DELETE CASCADE
);

INSERT INTO owners (name, address, preference) VALUES ('Shelter', 'Shelter Address', 'All');
