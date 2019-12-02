require_relative('../db/sql_runner.rb')
require_relative('animal.rb')

class Owner

	attr_accessor :name, :address, :preference
	attr_reader :owner_id
	def initialize(options)
		@owner_id = options['owner_id'].to_i() if options['owner_id']
		@name = options['name']
		@address = options['address']
		@preference = options['preference']
	end

	def self.all()
		sql = "SELECT * FROM owners"
		result = SqlRunner.run(sql)
		return result.map{|owner| self.new(owner)}
	end

	def self.all_pets()
		owners = all()
		pets_and_owner = {}

		for owner in owners
			pets = owner.get_pets()
			pets_and_owner["#{owner.owner_id}"] = {
				"owner_name" => owner.name,
				pets: []
			}

			for pet in pets
				pets_and_owner["#{owner.owner_id}"][:pets].push(pet.name)
			end
		end

		return pets_and_owner
	end

	def self.find(id)
		sql = "SELECT * FROM owners WHERE owner_id = $1"
		values = [id]
		result = SqlRunner.run(sql, values)
		return self.new(result[0])
	end

	def self.delete_all()
		sql = "DELETE FROM owners"
		SqlRunner.run(sql)
	end

	def self.delete_by_id(id)
		sql = "DELETE FROM owners WHERE owner_id = $1"
		values = [id]
		SqlRunner.run(sql, values)
	end

	def self.waiting_list()
		sql = "SELECT * FROM owners WHERE waiting_list = $1"
		values = [true]
		result = SqlRunner.run(sql, values)
		return result.map{|owner| self.new(owner)}
	end

	def self.current_owners()
		sql = "SELECT * FROM owners WHERE waiting_list = $1"
		values = [false]
		result = SqlRunner.run(sql, values)
		return result.map{|owner| self.new(owner)}
	end

	def save()
		sql = "INSERT INTO owners (name, address, preference) VALUES ($1, $2, $3) RETURNING owner_id"
		values = [@name, @address, @preference]
		owner_id = SqlRunner.run(sql, values)
		@owner_id = owner_id[0]['owner_id']
	end

	def adopt(animal)
		animal.adopt()
	end

	def get_pets()
		sql = "SELECT * FROM animals WHERE owner_id = $1"
		values = [@owner_id]
		results = SqlRunner.run(sql, values)
		return results.map{|pet| Animal.new(pet)}
	end

	def update()
		sql = "UPDATE owners SET (name, address, preference) = ($1, $2, $3) WHERE owner_id = $4"
		values = [@name, @address, @preference, @owner_id]
		SqlRunner.run(sql, values)
	end

	def delete()
		sql = "DELETE FROM owners WHERE owner_id = $1"
		values = [@owner_id]
		SqlRunner.run(sql, values)
	end

end
