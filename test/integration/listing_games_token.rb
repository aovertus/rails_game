require 'test_helper'

class ListingGamesTokenTest < ActionDispatch::IntegrationTest
	setup do
		@user = User.create!(email: "token@token.be", password: "test")
	end

	def token_header(token)
		ActionController::HttpAuthentication::Token.encode_credentials(token)
	end

	test "valid authentication with token" do
		get "api/games", {}, {"Authorization" => token_header(@user.auth_token)}
		assert_equal 200, response.status
		assert_equal Mime::JSON, response.content_type
	end

	test "invalid authentication" do
		get "api/games", {}, {"Authorization" => "fake"}
		assert_equal 401, response.status
	end
end
