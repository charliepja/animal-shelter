require_relative('../models/owner.rb')
require_relative('../models/animal.rb')

# INDEX

get '/volunteer/owner/index' do
	@owners = Owner.all()
	@pets = Owner.all_pets()
	erb(:"owners/index")
end


# NEW

get '/volunteer/owner/new' do
	erb(:"owners/new")
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
	erb(:"owners/show")
end

# EDIT

get '/volunteer/owner/:id/edit' do
	owner_id = params[:id].to_i()
	@owner = Owner.find(owner_id)
	erb(:"owners/edit")
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
	erb(:"owners/delete")
end

delete '/volunteer/owner/:id' do
	owner_id = params["id"].to_i()
	Owner.delete_by_id(owner_id)

	redirect "/volunteer/owner/index"
end
