require_relative('../db/sql_runner.rb')

class Adoption

	attr_reader :adoption_id, :animal_id
	def initialize(options)
		@adoption_id = options["adoption_id"] if options["adoption_id"]
		@initial_interview = options["initial_interview"] if options["initial_interview"]
		@initial_interview_date = options["initial_interview_date"] if options["initial_interview_date"]
		@meet_greet = options["meet_greet"] if options["meet_greet"]
		@meet_greet_date = options["meet_greet_date"] if options["meet_greet_date"]
		@home_visit = options["home_visit"] if options["home_visit"]
		@home_visit_date = options["home_visit_date"] if options["home_visit_date"]
		@vet_check = options["vet_check"] if options["vet_check"]
		@vet_check_date = options["vet_check_date"] if options["vet_check_date"]
		@take_home = options["take_home"] if options["take_home"]
		@take_home_date = options["take_home_date"] if options["take_home_date"]
		@animal_id = options["initial_interview"]
	end

	def self.save(animal_id)
		sql = "INSERT INTO adoption_process (animal_id) VALUES ($1) RETURNING adoption_id"
		values = [animal_id]
		result = SqlRunner.run(sql, values)
		@adoption_id = result[0]['adoption_id']
	end

	def self.progress(animal_id)
		sql = "SELECT * FROM adoption_process WHERE animal_id = $1"
		values = [animal_id]
		result = SqlRunner.run(sql, values)
		adopt_result = self.new(result[0])
		return adopt_result
	end

end
