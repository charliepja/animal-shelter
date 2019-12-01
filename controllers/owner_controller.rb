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

end

# UPDATE

post '/volunteer/owner/:id' do

end

# DESTROY

get '/volunteer/owner/:id/delete' do

end

delete '/volunteer/owner/index' do

end
