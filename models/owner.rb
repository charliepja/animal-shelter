class Owner

	attr_accessor :name, :address, :preference
	attr_reader :owner_id
	def initialize(options)
		@owner_id = options['owner_id'].to_i() if options['owner_id']
		@name = options['name']
		@address = options['address']
		@preference = options['preference']
	end

end
