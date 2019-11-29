require('minitest/autorun')
require('minitest/reporters')

require_relative('../models/animal.rb')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class OwnerTest < MiniTest::Test

	def setup()
		animal1_details = {
			"name" => "Ben",
			"breed" => "dog",
			"trained" => true,
			"admission_date" => 2019-11-30,
			"owner_id" => 1
		}

		@animal1 = Animal.new(animal1_details)
	end

	def test_can_create_owner()
		# Tests that name gets returned
		assert_equal("Ben", @animal1.name)
		# Tests that breed gets returned
		assert_equal("dog", @animal1.breed)
		# Tests trained gets returned
		assert_equal(true, @animal1.trained)
		# Tests that admission date gets returned
		assert_equal(2019-11-30, @animal1.admission_date)
		# Tests that owner id gets returned
		assert_equal(1, @animal1.owner_id)
	end

end
