extends GutTest

var missile_powerup: MissilePowerup = null


func before_each():
	missile_powerup = MissilePowerup.new()


func after_each():
	missile_powerup.free()
	PlayerStats.missiles = 0
	PlayerStats.max_missiles = 0


func test_should_increase_player_missles_max_by_three_when_picked_up():
	# arrange
	PlayerStats.missiles = 0
	PlayerStats.max_missiles = 0

	# act
	missile_powerup.pickup()

	# assert
	assert_eq(PlayerStats.missiles, 3)
	assert_eq(PlayerStats.max_missiles, 3)
	
	
func test_should_increase_player_missles_max_by_three_when_already_missiles_are_carried():
	# arrange
	PlayerStats.max_missiles = 6
	PlayerStats.missiles = 3

	# act
	missile_powerup.pickup()

	# assert
	assert_eq(PlayerStats.missiles, 6)
	assert_eq(PlayerStats.max_missiles, 9)
	
	
