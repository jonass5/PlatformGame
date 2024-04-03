extends GutTest

var world: World = null


func before_each():
	world = World.new()


func after_each():
	world.free()


func test_should_find_door_when_level_contains_only_one_door_from_old_level():
	# arrange
	var src_door = create_door("level0")
	var dest_door = create_door("level1")
	
	var doors: Array[Node] = [ src_door, dest_door ]
	var old_level_path = "level1"
	
	# act
	var found_door = world.find_door(doors, src_door, old_level_path)
	
	# assert
	assert_eq(found_door, dest_door)
	
	# tear down
	src_door.free()
	dest_door.free()


func test_should_find_door_when_door_points_to_old_level_and_door_connection_fits():
	# arrange
	var door_connection = DoorConnection.new()
	var src_door = create_door("level1", door_connection)
	var dest_door = create_door("level1", door_connection)	
	var wrong_door = create_door("level1", DoorConnection.new())
	
	var doors: Array[Node] = [ src_door, wrong_door, dest_door ]
	var old_level_path = "level1"
	
	# act
	var found_door = world.find_door(doors, src_door, old_level_path)
	
	# assert
	assert_eq(found_door, dest_door)
	
	# tear down
	src_door.free()
	dest_door.free()
	wrong_door.free()


func create_door(new_level_path: String, doorConnection: DoorConnection = null) -> Door:
	var door = Door.new()
	door.new_level_path = new_level_path
	door.connection = doorConnection
	return door
