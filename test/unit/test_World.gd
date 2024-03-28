extends GutTest

var world: World = null


func before_each():
	world = World.new()


func after_each():
	world.free()


func test_should():
	# arrange
	var src_door = Door.new()
	var dest_door = Door.new()
	dest_door.new_level_path = "level1"
	var doors: Array[Node] = [ src_door, dest_door ]
	var old_level_path = "level1"
	
	# act
	var found_door = world.find_door(doors, src_door, old_level_path)
	
	# assert
	assert_eq(found_door, dest_door)
	
	# tear down
	src_door.free()
	dest_door.free()
	
