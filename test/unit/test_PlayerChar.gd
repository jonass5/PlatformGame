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

