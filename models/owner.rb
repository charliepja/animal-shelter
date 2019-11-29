require_relative('../db/sql_runner.rb')

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

	def save()
		sql = "INSERT INTO owners (name, address, preference) VALUES ($1, $2, $3) RETURNING owner_id"
		values = [@name, @address, @preference]
		owner_id = SqlRunner.run(sql, values)
		@owner_id = owner_id[0]['owner_id']
	end

	def adopt(animal)
		animal.adopt()
	end

end
