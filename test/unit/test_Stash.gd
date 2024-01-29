extends GutTest

var stash: Stash = null


func before_each():
	stash = Stash.new()


func after_each():
	stash.free()


func test_should_return_null_when_id_does_not_exist():
	# act
	var result = stash.retrieve("player", "missiles")

	# assert
	assert_null(result)


func test_should_return_null_when_key_does_not_exist():
	# arrange
	stash.data = {
		"player": { }
	}

	# act
	var result = stash.retrieve("player", "missiles")

	# assert
	assert_null(result)


func test_should_retrieve_value_when_value_exists():
	# arrange
	stash.data = {
		"player": {
			"missiles": 3
		}
	}

	# act
	var result = stash.retrieve("player", "missiles")

	# assert
	assert_eq(result, 3)


func test_should_store_new_value_when_value_not_exists():
	# act
	stash.stash("myId", "myKey", 10)
	
	# assert
	assert_eq(stash.data.myId.myKey, 10)


func test_should_update_value_when_value_already_exists():
	# arrange
	stash.data.myId = {}
	stash.data.myId.myKey = 10
	
	# act
	stash.stash("myId", "myKey", 20)
	
	# assert
	assert_eq(stash.data.myId.myKey, 20)
	
	
func test_should_store_key_free_with_node_path_as_id_when_node_is_given():
	# arrange
	var node = Node2D.new()
	node.name = "myNode"
	add_child(node)
	
	# act
	stash.freed(node)
	
	# assert
	assert_true(stash.data[str(node.get_path())]["freed"])
	
	# tear down
	node.free()
	

