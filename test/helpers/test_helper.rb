require "capybara/rails"

class ActionDispatch::IntegrationTest
	include Capybara::DSL

	def teardown
		Capybara.reset_session!
		Capybara.use_default_driver
	end
end