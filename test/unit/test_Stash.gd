extends GutTest

var stash: Stash = null


func before_each():
	stash = Stash.new()


func after_each():
	stash.free()

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
