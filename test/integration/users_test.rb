require "test_helper"

class GamesTest < ActionDispatch::IntegrationTest
	test "sign user" do
		visit login_path
		fill_in "Email", with: "a.overtus@live.be"
		fill_in "Password", with: "alexandre"
		click_on "Login"
		assert games_path, current_path
	end
end