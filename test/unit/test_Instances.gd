extends GutTest

var instances: Instances = null
const LEVEL_FILE_PATH = "res://world/levels/level_01_Tutorial.tscn"


func before_each():
	instances = Instances.new()


func after_each():
	instances.free()


func test_should_stash_player_position_and_level_path_in_stash():
	# arrange
	WorldStash.data = {}
	var player = Player.new()
	player.global_position = Vector2(100, 200)
	instances.player = player
	var level = preload(LEVEL_FILE_PATH).instantiate()
	instances.level = level

	# act
	instances.stash_stats()

	# assert
	assert_eq(WorldStash.data["player"]["x"], 100)
	assert_eq(WorldStash.data["player"]["y"], 200)
	assert_eq(WorldStash.data["level"]["file_path"], LEVEL_FILE_PATH)

	# tear down
	player.free()
	level.free()


func test_should_retrieve_data_from_stash():
	# arrange
	WorldStash.data = { "player" = {} }
	WorldStash.data["player"]["x"] = 10
	WorldStash.data["player"]["y"] = 20
	var player = Player.new()
	instances.player = player

	# act
	instances.retrieve_stats()

	# assert
	assert_eq(player.global_position.x, 10)
	assert_eq(player.global_position.y, 20)
	
	# tear down
	player.free()

