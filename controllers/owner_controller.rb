require_relative('../models/owner.rb')
require_relative('../models/animal.rb')

# INDEX

get '/volunteer/owner/index' do
	@owners = Owner.all()
	@pets = Owner.all_pets()
	erb(:"owners/index")
end
