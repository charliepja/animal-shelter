require_relative('../models/animal.rb')
require_relative('../db/sql_runner.rb')

# PUBLIC VIEW INDEX
get '/adopt' do
	@pets = Animal.all()
	erb(:"animals/adopt")
end

# PUBLIC VIEW INDEX SORT BY
post '/adopt' do
	p params
	values = []
	sql_array = ["SELECT * FROM animals"]

	if params[:type].empty? == false
		values.push(params[:type])
		where_type = "WHERE breed = $1"
		sql_array.push(where_type)
	end

	if params[:trained].empty? == false
		if params[:trained] == 'yes'
			values.push("true")
		else
			values.push("false")
		end
		if params[:type].empty? == false
			where_trained = "AND trained = $2"
		else
			where_trained = "WHERE trained = $1"
		end
		sql_array.push(where_trained)
	end

	if params[:sort].empty? == false
		values.push(params[:sort])
		order_by = "ORDER BY $#{values.count()}"
		sql_array.push(order_by)
	end

	# TO DO: Need to figure out how to change string to table Name
	sql = sql_array.join(" ")
	p sql
	results = SqlRunner.run(sql, values)
	@pets = results.map{|animal| Animal.new(animal)}

	erb(:"animals/adopt")
end
