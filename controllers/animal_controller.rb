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
