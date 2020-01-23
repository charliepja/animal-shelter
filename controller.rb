require('sinatra')
require('sinatra/contrib/all') if development?

require_relative('./controllers/public/animal_controller.rb')
require_relative('./controllers/volunteer/animal_controller.rb')
require_relative('./controllers/public/owner_controller.rb')
require_relative('./controllers/volunteer/owner_controller.rb')


class App < Sinatra::Base
	get '/' do

		erb(:home)

	end

	get '/about' do
		erb(:"public/about")
	end

	get '/faq' do
		erb(:"public/faq")
	end

	get '/contact' do
		time_now = Time.now()
		if time_now.hour > 16 || time_now.hour < 9
			@open_status = "Closed"
		elsif time_now.hour > 8 && time_now.hour < 17
			@open_status = "Opened"
		end
		erb(:"public/contact")
	end

	get '/donate' do
		erb(:"public/donate")
	end

	post '/donate' do
		erb(:"public/thankyou")
	end
end
