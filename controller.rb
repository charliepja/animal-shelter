require('sinatra')
require('sinatra/contrib/all')
require('pry')
also_reload('./models/*')
also_reload('./views/*')

# require_relative('./controllers/animal_controller.rb')
# require_relative('./controllers/owner_controller.rb')

get '/' do

	erb(:home)

end
