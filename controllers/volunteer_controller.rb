require_relative('../models/animal.rb')
require_relative('../models/owner.rb')
require_relative('../db/sql_runner.rb')

get '/volunteer' do
	erb(:"volunteers/home", :layout => :volunteer)
end

# INDEX
get '/volunteer/animal/index' do
	@pets = Animal.all()
	erb(:"volunteers/animals/index", :layout => :volunteer)
end

# NEW

get '/volunteer/animal/new' do
	erb(:"volunteers/animals/new", :layout => :volunteer)
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
	@training = @pet.view_training()
	erb(:"volunteers/animals/show", :layout => :volunteer)
end

# EDIT
get '/volunteer/animal/:id/edit' do
	pet_id = params[:id].to_i()
	@pet = Animal.find_by_id(pet_id)
	@training = @pet.view_training()
	erb(:"volunteers/animals/edit", :layout => :volunteer)
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
	erb(:"volunteers/animals/destroy", :layout => :volunteer)
end

delete '/volunteer/animal/:id' do
	pet_id = params[:id].to_i()
	Animal.delete_by_id(pet_id)

	redirect "/volunteer/animal/index"
end

# INDEX

get '/volunteer/owner/index' do
	@owners = Owner.all()
	@pets = Owner.all_pets()
	erb(:"volunteers/owners/index", :layout => :volunteer)
end


# NEW

get '/volunteer/owner/new' do
	erb(:"volunteers/owners/new", :layout => :volunteer)
end

# CREATE

post '/volunteer/owner/index' do
	new_owner = Owner.new(params)
	new_owner.save()

	redirect "/volunteer/owner/index"
end

# SHOW

get '/volunteer/owner/:id' do
	owner_id = params[:id].to_i()
	@owner = Owner.find(owner_id)
	@pets = @owner.get_pets()
	erb(:"volunteers/owners/show", :layout => :volunteer)
end

# EDIT

get '/volunteer/owner/:id/edit' do
	owner_id = params[:id].to_i()
	@owner = Owner.find(owner_id)
	erb(:"volunteers/owners/edit", :layout => :volunteer)
end

# UPDATE

post '/volunteer/owner/:id' do
	owner_id = params["owner_id"].to_i()
	@owner = Owner.find(owner_id)
	@owner.name = params["name"] if (params["name"] && params["name"].empty? == false)
	@owner.address = params["address"] if (params["address"] && params["address"].empty? == false)
	@owner.preference = params["preference"] if (params["preference"] && params["preference"].empty? == false)

	@owner.update()

	redirect "/volunteer/owner/#{owner_id}"
end

# DESTROY

get '/volunteer/owner/:id/delete' do
	owner_id = params[:id].to_i()
	@owner = Owner.find(owner_id)
	erb(:"volunteers/owners/delete", :layout => :volunteer)
end

delete '/volunteer/owner/:id' do
	owner_id = params["id"].to_i()
	Owner.delete_by_id(owner_id)

	redirect "/volunteer/owner/index"
end
