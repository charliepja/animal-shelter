require_relative('../../models/animal.rb')

# PUBLIC VIEW INDEX
get '/adopt' do
	@pets = Animal.all()
	erb(:"public/animals/adopt")
end

# PUBLIC VIEW INDEX SORT BY
post '/adopt/filtered' do
	p params
	opt = [
		["breed", "#{params["breed"]}"],
		["type", "#{params["type"]}"],
		["trained", "#{params["trained"]}"]
	]
	@pets = Animal.filter(opt, params["sort"])

	erb(:"public/animals/adopt")
end
