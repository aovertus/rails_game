require 'test_helper'

class ListingGamesTest < ActionDispatch::IntegrationTest
	setup { @user = User.create!(email: "a.overtus@live.be", hashed_password: "alexandre")}



	test "valid username and password" do 
		get "/api/games", {}, {"Authorization" => encode_credentials(@user.email, @user.hashed_password)}
		assert_equal 200, response.status
	end

	test "missing credentials" do
		get "/api/games", {},{}
		assert_equal 401, response.status		
	end
end
