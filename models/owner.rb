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

end
