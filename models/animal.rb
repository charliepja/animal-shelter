require_relative('training.rb')
require_relative('../db/sql_runner.rb')

class Animal

	attr_accessor :name, :breed, :trained, :owner_id
	attr_reader :admission_date, :animal_id
	def initialize(options)
		if options['trained'] == 't'
			options['trained'] = true
		elsif options['trained'] == 'f'
			options['trained'] = false
		end

		@animal_id = options['animal_id'].to_i() if options['animal_id']
		@name = options['name']
		@breed = options['breed']
		@trained = options['trained']
		@admission_date = options['admission_date']
		@owner_id = options['owner_id'].to_i()
	end

	# works
	def self.all()
		sql = "SELECT * FROM animals"
		result = SqlRunner.run(sql)
		return result.map{|animal| self.new(animal)}
	end

	def self.find_by_id(id)
		sql = "SELECT * FROM animals WHERE animal_id = $1"
		values = [id]
		result = SqlRunner.run(sql, values)
		return self.new(result[0])
	end

	# works
	def self.get_owner(owner)
		sql = "SELECT * FROM animals WHERE owner_id = $1"
		values = [owner.owner_id]
		result = SqlRunner.run(sql, values)
		return result.map{|animal| self.new(animal)}
	end

	def self.delete_all()
		sql = "DELETE FROM animals"
		SqlRunner.run(sql)
	end

	def self.delete_by_id(id)
		sql = "DELETE FROM animals WHERE animal_id = $1"
		values = [id]
		SqlRunner.run(sql, values)
	end

	# works
	def save()
		sql = "INSERT INTO animals (name, breed, trained, admission_date, owner_id) VALUES ($1, $2, $3, $4, $5) RETURNING animal_id"
		values = [@name, @breed, @trained, @admission_date, 1]
		result = SqlRunner.run(sql, values)
		@animal_id = result[0]['animal_id']
		add_training()
	end

	def can_adopt(answer)
		sql = "UPDATE animals SET trained = $1 WHERE animal_id = $2"
		values = [answer, @animal_id]
		SqlRunner.run(sql, values)
	end

	def adopt(owner)
		new_owner = owner.owner_id
		sql = "UPDATE animals SET owner_id = $1 WHERE animal_id = $2"
		values = [new_owner, @animal_id]
		SqlRunner.run(sql, values)
	end

	def update()
		sql = "UPDATE animals SET (name, breed, trained, owner_id) = ($1, $2, $3, $4) WHERE animal_id = $5"
		values = [@name, @breed, @trained, @owner_id, @animal_id]
		SqlRunner.run(sql, values)
	end

	def single_update(var, val)
		case var
		when "name"
			@name = "#{val}"
		when "breed"
			@breed = "#{val}"
		when "trained"
			@trained = true if "#{val}" == "yes"
			@trained = false if "#{val}" == "no"
		when "owner_id"
			@owner_id = "#{val}".to_i()
		else
			return
		end
		update()
	end

	def delete()
		sql = "DELETE FROM animals WHERE animal_id = $1"
		values = [@animal_id]
		SqlRunner.run(sql, values)
	end

	def add_training()
		Training.save(@animal_id)
	end

	def view_training()
		Training.find(@animal_id)
	end

	def update_single_train(var, val)
		p var
		p val
		if val == 'yes'
			b_val = true
		elsif val == 'no'
			b_val = false
		else
			return
		end

		case var
		when "toilet_trained"
			update_training("toilet_trained", b_val)
		when "sit"
			update_training("sit", b_val)
		when "stay"
			update_training("stay", b_val)
		when "come"
			update_training("come", b_val)
		when "heel"
			update_training("heel", b_val)
		when "down"
			update_training("down", b_val)
		when "socialised"
			update_training("socialised", b_val)
		else
			return
		end
	end

	def update_training(set, value)
		Training.update(@animal_id, set, value)
	end

	def delete_training()
		Training.delete(@animal_id)
	end

end
