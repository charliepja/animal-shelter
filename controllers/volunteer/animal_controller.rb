require_relative('../../models/animal.rb')
require_relative('../../models/owner.rb')


class App < Sinatra::Base

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

	get '/volunteer/animal/:id/edit/adoption' do
		pet_id = params[:id].to_i()
		@pet = Animal.find_by_id(pet_id)
		@adopt = @pet.adopt_progress
		p @adopt
		erb(:"volunteers/animals/adoption", :layout => :volunteer)
	end

	get '/volunteer/animal/:id/edit/training' do
		pet_id = params[:id].to_i()
		@pet = Animal.find_by_id(pet_id)
		@training = @pet.view_training()
		erb(:"volunteers/animals/training", :layout => :volunteer)
	end

	# UPDATE
	post '/volunteer/animal/:id/edit' do
		pet_id = params[:animal_id].to_i()
		@pet = Animal.find_by_id(pet_id)
		@pet.update(params)
		redirect "/volunteer/animal/#{pet_id}"
	end

	post '/volunteer/animal/:id/edit/training' do
		pet_id = params[:animal_id].to_i()
		@pet = Animal.find_by_id(pet_id)
		@pet.update_training(params)
		redirect "/volunteer/animal/#{pet_id}"
	end

	put '/volunteer/animal/:id/edit/adoption' do
		pet_id = params[:animal_id].to_i()
		@pet = Animal.find_by_id(pet_id)
		update_key = params.keys()
		update_values = params.values()
		@pet.update_adopt(update_key[2], update_values[2])

		redirect "/volunteer/animal/#{pet_id}/edit/adoption"
	end

	post '/volunteer/animal/:id/edit/adoption' do
		pet_id = params[:id].to_i()
		@pet = Animal.find_by_id(pet_id)
		@pet.start_adoption()
		@adopt = @pet.adopt_progress

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

end
