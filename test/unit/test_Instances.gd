extends GutTest

var instances: Instances = null


func before_each():
	instances = Instances.new()


func after_each():
	instances.free()


func test_should_stash_data_in_WorldStash():
	# arrange
	WorldStash.data = {}
	var player = Player.new()
	player.global_position = Vector2(100, 200)
	instances.player = player
	var level = preload("res://world/levels/level_01_Tutorial.tscn").instantiate()
	instances.level = level
	
	# act
	instances.stash_stats()
	
	# assert
	assert_eq(WorldStash.data["player"]["x"], 100)
	assert_eq(WorldStash.data["player"]["y"], 200)
	assert_eq(WorldStash.data["level"]["file_path"], "res://world/levels/level_01_Tutorial.tscn")
	
	# tear down
	player.free()
	level.free()
	
