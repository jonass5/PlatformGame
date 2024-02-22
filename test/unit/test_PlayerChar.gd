extends GutTest

var player: PlayerChar = null


func before_each():
	player = PlayerChar.new()


func after_each():
	player.free()


func test_should_cool_down_when_weapon_is_hot():
	# arrange
	player.cool_down_time = 0.5

	# act
	player.cool_down(0.2)

	# assert
	assert_eq(player.cool_down_time, 0.3)


func test_should_not_cool_down_when_weapon_is_cold():
	# arrange
	player.cool_down_time = 0.0

	# act
	player.cool_down(0.2)

	# assert
	assert_eq(player.cool_down_time, 0.0)


func test_should_return_false_when_weapon_is_not_cold():
	# arrange
	player.cool_down_time = 0.2
	
	# act
	var result = player.is_weapon_cold()
	
	# assert
	assert_false(result)


func test_should_return_true_when_weapon_is_cold():
	# arrange
	player.cool_down_time = 0.0
	
	# act
	var result = player.is_weapon_cold()
	
	# assert
	assert_true(result)
