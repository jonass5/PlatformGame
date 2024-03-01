extends GutTest


func test_should_return_true_when_player_has_missiles():
	# arrange
	PlayerStats.set_max_missiles(3)
	PlayerStats.set_missiles(3)
	
	# act
	var result = PlayerStats.has_missiles()
	
	# assert
	assert_true(result)


func test_should_return_false_when_player_has_no_missiles():
	# arrange
	PlayerStats.set_missiles(0)
	
	# act
	var result = PlayerStats.has_missiles()
	
	# assert
	assert_false(result)
	
