require_relative('../models/animal.rb')
require_relative('../db/sql_runner.rb')


# INDEX
get '/volunteer/animal/index' do
	@pets = Animal.all()
	erb(:"animals/index")
end

# NEW

get '/volunteer/animal/new' do
	erb(:"animals/new")
end

# CREATE

post '/volunteer/animal/index' do
	new_pet = Animal.new(params)
	new_pet.save()
	redirect "/volunteer/animal/index"
end

# SHOW
get '/volunteer/animal/:id' do
	pet_id = params[:id].to_i()
	@pet = Animal.find_by_id(pet_id)
	erb(:"animals/show")
end

# EDIT
get '/volunteer/animal/:id/edit' do
	pet_id = params[:id].to_i()
	@pet = Animal.find_by_id(pet_id)
	erb(:"animals/edit")
end

# UPDATE
post '/volunteer/animal/:id' do
	pet_id = params[:animal_id].to_i()
	@pet = Animal.find_by_id(pet_id)
	@pet.name = params['name'] if params['name'].empty? == false
	@pet.breed = params['breed'] if params['breed'].empty? == false
	@pet.trained = params['trained'] if params['trained'].empty? == false
	@pet.owner_id = params['owner_id'].to_i() if params['owner_id'].empty? == false

	@pet.update()

	redirect "/volunteer/animal/#{pet_id}"
end

# DESTROY

get '/volunteer/animal/:id/delete' do
	pet_id = params[:id].to_i()
	@pet = Animal.find_by_id(pet_id)
	erb(:"animals/destroy")
end

delete '/volunteer/animal/:id' do
	pet_id = params[:id].to_i()
	Animal.delete_by_id(pet_id)

	redirect "/volunteer/animal/index"
end

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
