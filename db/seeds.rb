require('pry')
require_relative('../models/animal.rb')
require_relative('../models/owner.rb')

owner1_details = {
	"name" => "Charlie Anderson",
	"address" => "1 Fake Street",
	"preference" => "all"
}

owner2_details = {
	"name" => "Thomas Jenkins",
	"address" => "2 Fake Street",
	"preference" => "all"
}

owner1 = Owner.new(owner1_details)
owner2 = Owner.new(owner2_details)

owner1.save()
owner2.save()

binding.pry

nil
