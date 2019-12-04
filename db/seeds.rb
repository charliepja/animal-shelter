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

animal1_details = {
	"name" => "Ben",
	"type" => "Dog",
	"breed" => "border_collie",
	"microchip" => 12345,
	"trained" => true,
	"admission_date" => Time.new(2019, "nov", 30),
}

animal2_details = {
	"name" => "Shadow",
	"type" => "Dog",
	"breed" => "husky",
	"microchip" => 123456,
	"trained" => true,
	"admission_date" => Time.new(2019, "nov", 30),
}

animal1 = Animal.new(animal1_details)
animal2 = Animal.new(animal2_details)

animal1.save()
animal2.save()

binding.pry

nil
