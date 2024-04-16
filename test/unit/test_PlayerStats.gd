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


func test_should_store_missiles_in_world_stash_when_called():
	# arrange
	PlayerStats.set_max_missiles(5)
	PlayerStats.set_missiles(5)
	
	# act
	PlayerStats.stash_stats()
	
	# assert
	assert_eq(WorldStash.data.player.missiles, 5)


func test_should_retrieve_missiles_from_world_stash_when_called():
	# arrange
	WorldStash.stash("player", "max_missiles", 10)
	WorldStash.stash("player", "missiles", 10)
	
	# act
	PlayerStats.retrieve_stats()
	
	# assert
	assert_eq(PlayerStats.missiles, 10)


func test_should_reduce_health_when_player_got_hurt():
	# arrange
	PlayerStats.max_health = 10
	PlayerStats.health = 10
	
	# act
	var result = PlayerStats.hurt(1)
	
	# assert
	assert_eq(result, 9)
	assert_eq(PlayerStats.health, 9)
	
	
func test_should_reduce_health_never_below_zero_when_player_got_hurt():
		# arrange
	PlayerStats.max_health = 3
	PlayerStats.health = 3
	
	# act
	var result = PlayerStats.hurt(5)
	
	# assert
	assert_eq(result, 0)
	assert_eq(PlayerStats.health, 0)

