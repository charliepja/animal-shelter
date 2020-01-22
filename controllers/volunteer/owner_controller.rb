require_relative('../../models/animal.rb')
require_relative('../../models/owner.rb')


class App < Sinatra::Base

	# INDEX

	get '/volunteer/owner/index' do
		@owners = Owner.current_owners()
		@pets = Owner.all_pets()
		erb(:"volunteers/owners/index", :layout => :volunteer)
	end

	get '/volunteer/owner/index/filter' do
		@owners = Owner.waiting_list()
		erb(:"volunteers/owners/indexf", :layout => :volunteer)
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

end
