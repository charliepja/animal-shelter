DROP TABLE IF EXISTS training;
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
	type VARCHAR,
	breed VARCHAR,
	microchip INT,
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

CREATE TABLE adoption_process (
	adoption_id SERIAL PRIMARY KEY,
	initial_interview BOOLEAN,
	initial_interview_date DATE,
	meet_greet BOOLEAN,
	meet_greet_date DATE,
	home_visit BOOLEAN,
	home_visit_date DATE,
	vet_check BOOLEAN,
	vet_check_date DATE,
	take_home BOOLEAN,
	take_home_date DATE
	animal_id INT REFERENCES animals(animal_id) ON DELETE CASCADE
);

INSERT INTO owners (name, address, preference) VALUES ('Shelter', 'Shelter Address', 'All');
