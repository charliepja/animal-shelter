DROP TABLE IF EXISTS training;
DROP TABLE IF EXISTS adoption_process;
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS owners;

CREATE TABLE owners (
	owner_id SERIAL PRIMARY KEY,
	name VARCHAR,
	address VARCHAR,
	preference VARCHAR,
	waiting_list BOOLEAN DEFAULT true
);

CREATE TABLE animals (
	animal_id SERIAL PRIMARY KEY,
	name VARCHAR,
	type VARCHAR,
	breed VARCHAR,
	microchip INT UNIQUE,
	trained BOOLEAN,
	admission_date DATE,
	img_url VARCHAR,
	owner_id INT DEFAULT 1 REFERENCES owners(owner_id) ON DELETE SET DEFAULT
);

CREATE TABLE training (
	training_plan_id SERIAL PRIMARY KEY,
	toilet_trained VARCHAR DEFAULT 'Not Started',
	sit VARCHAR DEFAULT 'Not Started',
	stay VARCHAR DEFAULT 'Not Started',
	come VARCHAR DEFAULT 'Not Started',
	heel VARCHAR DEFAULT 'Not Started',
	down VARCHAR DEFAULT 'Not Started',
	socialised VARCHAR DEFAULT 'Not Started',
	animal_id INT REFERENCES animals(animal_id) ON DELETE CASCADE
);

CREATE TABLE adoption_process (
	adoption_id SERIAL PRIMARY KEY,
	initial_interview VARCHAR DEFAULT 'Not Set',
	initial_interview_date DATE,
	meet_greet VARCHAR DEFAULT 'Not Set',
	meet_greet_date DATE,
	home_visit VARCHAR DEFAULT 'Not Set',
	home_visit_date DATE,
	vet_check VARCHAR DEFAULT 'Not Set',
	vet_check_date DATE,
	take_home VARCHAR DEFAULT 'Not Set',
	take_home_date DATE,
	animal_id INT UNIQUE REFERENCES animals(animal_id) ON DELETE CASCADE
);

INSERT INTO owners (name, address, preference, waiting_list) VALUES ('Shelter', 'Shelter Address', 'All', false);
