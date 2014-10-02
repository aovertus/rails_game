class UpdatingEpisodesTest < ActionDispatch::IntegrationTest
	setup{
		@game = Game.create!(title: "Integration", note: 8)
	}

	test "successful update" do 
		patch "games/#{@game.id}",
		{game: {title: "Integration edit"}}.to_json,
		{"Accept" => Mime::JSON, "Content-type"=> Mime::JSON.to_s}

		assert_equal 200, response.status
		assert_equal "Integration edit", @game.reload.title
	end

	test "show api" do 
		get "api/games",
		{ format: "json" },
		{"Accept" => Mime::JSON, "Content-type"=> Mime::JSON.to_s, "HTTP_AUTHORIZATION" => "Token token=railsgames"}

		assert_equal 200, response.status
	end


	test "successful update api" do 
		patch "api/games/#{@game.id}",
		{game: {title: "Integration edit"}}.to_json,
		{"Accept" => Mime::JSON, "Content-type"=> Mime::JSON.to_s, "HTTP_AUTHORIZATION" => "Token token=railsgames"}

		assert_equal 200, response.status
		assert_equal "Integration edit", @game.reload.title
	end


end