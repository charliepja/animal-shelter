require_relative('../models/animal.rb')
require_relative('../db/sql_runner.rb')

# PUBLIC VIEW INDEX
get '/adopt' do
	@pets = Animal.all()
	erb(:"animals/adopt")
end

# PUBLIC VIEW INDEX SORT BY
post '/adopt/filtered' do
	opt = [params["type"], params["trained"]]
	@pets = Animal.filter(opt, params["sort"])

	erb(:"animals/adopt")
end
