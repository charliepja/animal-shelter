require('minitest/autorun')
require('minitest/reporters')

require_relative('../models/owner.rb')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class OwnerTest < MiniTest::Test

	def setup()
		owner1_details = {
			"name" => "Charlie Anderson",
			"address" => "1 Fake Street",
			"preference" => "All",
		}

		@owner1 = Owner.new(owner1_details)
	end

	def test_can_create_owner()
		# Tests that name comes back
		assert_equal("Charlie Anderson", @owner1.name)
		# Tests that address comes back
		assert_equal("1 Fake Street", @owner1.address)
		# Tests that preference comes back
		assert_equal("All", @owner1.preference)
	end

end
