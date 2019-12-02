require('sinatra')
require('sinatra/contrib/all')
require('pry')
also_reload('./models/*')
also_reload('./views/*')

require_relative('./controllers/animal_controller.rb')
require_relative('./controllers/owner_controller.rb')
require_relative('./controllers/volunteer_controller.rb')

get '/' do

	erb(:home)

end

get '/about' do
	erb(:about)
end

get '/faq' do
	erb(:faq)
end

get '/contact' do
	time_now = Time.now()
	if time_now.hour > 16 || time_now.hour < 9
		@open_status = "Closed"
	elsif time_now.hour > 8 && time_now.hour < 17
		@open_status = "Opened"
	end
	erb(:contact)
end

get '/donate' do
	erb(:donate)
end
