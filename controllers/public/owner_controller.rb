require_relative('../../models/owner.rb')
require_relative('../../models/animal.rb')

# PUBLIC JOIN WAITING LIST

get '/waiting' do
	erb(:"public/owners/waiting")
end

post '/waiting' do
	@new_owner = Owner.new(params)
	@new_owner.save()
	erb(:"public/owners/joined")
end
