class Animal

	attr_accessor :name, :breed, :trained
	attr_reader :admission_date, :animal_id, :owner_id
	def initialize(options)
		@animal_id = options['animal_id'].to_i() if options['animal_id']
		@name = options['name']
		@breed = options['breed']
		@trained = options['trained']
		@admission_date = options['admission_date']
		@owner_id = options['owner_id'].to_i()
	end

end
