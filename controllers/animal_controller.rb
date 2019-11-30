require_relative('../models/animal.rb')
require_relative('../db/sql_runner.rb')


get '/adopt' do
	@pets = Animal.all()
	erb(:"animals/adopt")
end

post '/adopt' do
	filter_type = params[:type]

	# type = dog, trained = yes, sort = name
	# SELECT * from animals WHERE breed = 'Dog' AND trained = true ORDER BY name;

	# TO DO: Need to figure out how to change string to table Name
	
	if filter_type.length > 0 && params[:trained].length > 0 && params[:sort].length > 0
		if params[:trained] == 'yes'
			filter_trained = true
		elsif params[:trained] == 'no'
			filter_trained = false
		end

		case params[:sort]
		when '1'
			filter_sort = "type"
		when '2'
			filter_sort = "name"
		when '3'
			filter_sort = "trained"
		when '4'
			filter_sort = "admission_date"
		end

		sql = "SELECT * FROM animals WHERE breed = $1 AND trained = $2 ORDER BY $3"
		p "SELECT * FROM animals WHERE breed = #{filter_type} AND trained = #{filter_trained} ORDER BY #{filter_sort}"
		values = [filter_type, filter_trained, filter_sort]
		results = SqlRunner.run(sql, values)
		@pets = results.map{|animal| Animal.new(animal)}
	end

	erb(:"animals/adopt")
end
