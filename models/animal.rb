require_relative('training.rb')
require_relative('adoption.rb')
require_relative('../db/sql_runner.rb')

class Animal

	attr_accessor :name, :breed, :trained, :owner_id, :type, :microchip, :img_url
	attr_reader :admission_date, :animal_id
	def initialize(options)
		if options['trained'] == 't'
			options['trained'] = true
		elsif options['trained'] == 'f'
			options['trained'] = false
		end

		@animal_id = options['animal_id'].to_i() if options['animal_id']
		@name = options['name']
		@type = options['type']
		@breed = options['breed']
		@microchip = options['microchip'].to_i()
		@trained = options['trained']
		@admission_date = options['admission_date']
		@img_url = options['img_url']
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
		sql = "INSERT INTO animals (name, type, breed, microchip, trained, admission_date, img_url, owner_id) VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING animal_id"
		values = [@name, @type, @breed, @microchip, @trained, @admission_date, @img_url, 1]
		result = SqlRunner.run(sql, values)
		@animal_id = result[0]['animal_id']
		add_training()
	end

	def start_adoption()
		Adoption.save(@animal_id)
	end

	def adopt_progress()
		Adoption.progress(@animal_id)
	end

	def update_adopt(key, value)
		Adoption.single_update(@animal_id, key, value)
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

	def update(params)
		params.each {|key, value|
			if value.empty? == false && key != "animal_id"
				single_update(key, value)
			end
		}
		sql = "UPDATE animals SET (name, type, breed, microchip, trained, img_url, owner_id) = ($1, $2, $3, $4, $5, $6, $7) WHERE animal_id = $8"
		values = [@name, @type, @breed, @microchip, @trained, @img_url, @owner_id, @animal_id]
		SqlRunner.run(sql, values)
	end

	def single_update(var, val)
		case var
		when "name"
			@name = "#{val}"
		when "type"
			@type = "#{val}"
		when "breed"
			@breed = "#{val}"
		when "microchip"
			@microchip = val.to_i()
		when "trained"
			@trained = true if "#{val}" == "yes"
			@trained = false if "#{val}" == "no"
		when "img_url"
			@img_url = "#{val}"
		when "owner_id"
			@owner_id = "#{val}".to_i()
		else
			return
		end
	end

	def delete()
		sql = "DELETE FROM animals WHERE animal_id = $1"
		values = [@animal_id]
		SqlRunner.run(sql, values)
	end

	def self.filter(options, sort="")
		values = []
		new_options = []
		for option in options
			if option[1].empty? == false
				new_options.push(option)
				if option[1] == "yes"
					values.push(true)
				elsif option[1] == "no"
					values.push(false)
				else
					values.push(option[1])
				end
			end
		end

		if values.count == 3
			sql_where = "SELECT * FROM animals WHERE type = $1 AND breed = $2 AND trained = $3"
		elsif values.count == 2
			sql_where = "SELECT * FROM animals WHERE #{new_options[0][0]} = $1 AND #{new_options[1][0]} = $2"
		elsif values.count == 1
			sql_where = "SELECT * FROM animals WHERE #{new_options[0][0]} = $1"
		end

		if sort.empty? == false
			case sort
			when "type"
				sql_order = "ORDER BY breed"
			when "name"
				sql_order = "ORDER BY name"
			when "trained"
				sql_order = "ORDER BY trained"
			when "admission_date"
				sql_order = "ORDER BY admission_date"
			else
				return
			end
		end

		if sql_where && sql_order
			sql = sql_where + " "+ sql_order
		elsif (sql_where && sql_where.length > 0)
			sql = sql_where
		elsif (sql_order && sql_order.length > 0)
			sql = "SELECT * FROM animals " + sql_order
		else
			return
		end

		result = SqlRunner.run(sql, values)
		return result.map{|animal| self.new(animal)}
	end

	def add_training()
		Training.save(@animal_id)
	end

	def view_training()
		Training.find(@animal_id)
	end

	def update_training(params)
		params.each{|key, value|
			if value.empty? == false && key != "animal_id"
				case key
				when "toilet_trained"
					update_single_training("toilet_trained", value)
				when "sit"
					update_single_training("sit", value)
				when "stay"
					update_single_training("stay", value)
				when "come"
					update_single_training("come", value)
				when "heel"
					update_single_training("heel", value)
				when "down"
					update_single_training("down", value)
				when "socialised"
					update_single_training("socialised", value)
				else
					return
				end
			end
		}
	end

	def update_single_training(set, value)
		Training.update(@animal_id, set, value)
	end

	def delete_training()
		Training.delete(@animal_id)
	end

end
