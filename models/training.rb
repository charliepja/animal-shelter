require_relative('../db/sql_runner.rb')

class Training

	attr_accessor :toilet_trained, :sit, :stay, :come, :heel, :down, :socialised
	attr_reader :training_plan_id, :animal_id
	def initialize(options)
		@training_plan_id = options['training_plan_id'].to_i() if options['training_plan_id']
		@toilet_trained = options['toilet_trained']
		@sit = options['sit']
		@stay = options['stay']
		@come = options['come']
		@heel = options['heel']
		@down = options['down']
		@socialised = options['socialised']
		@animal_id = options['animal_id'].to_i()
	end

	# CREATE
	def self.save(animal_id)
		sql = "INSERT INTO training (animal_id) VALUES ($1)"
		values = [animal_id]
		SqlRunner.run(sql, values)
	end

	# READ
	def self.find(animal_id)
		sql = "SELECT * FROM training WHERE animal_id = $1"
		values = [animal_id]
		result = SqlRunner.run(sql, values)
		return self.new(result[0])
	end

	# UPDATE
	def self.update(animal_id, set, value)
		sql = "UPDATE training SET $1 = $2 WHERE animal_id = $3"
		values = [set, value, animal_id]
		SqlRunner.run(sql, values)
	end

	# DELETE
	def self.delete(animal_id)
		sql = "DELETE FROM training WHERE animal_id = $1"
		values = [animal_id]
		SqlRunner.run(sql, values)
	end

	def self.delete_all()
		sql = "DELETE FROM training"
		SqlRunner.run(sql)
	end

end
