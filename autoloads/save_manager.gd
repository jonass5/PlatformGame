extends Node

const TEST_PATH: String = "res://save.txt"
const PROD_PATH: String = "user://platform_game_save.save"

var save_path: String = PROD_PATH
var loading: bool = false


func save_game():
	MainInstances.stash_stats()
	PlayerStats.stash_stats()
	
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	var data_string = JSON.stringify(WorldStash.data)
	save_file.store_string(data_string)
	save_file.close()


func is_save_game_available():
	return FileAccess.file_exists(save_path)


func load_game():
	var load_file = FileAccess.open(save_path, FileAccess.READ)
	if not load_file is FileAccess:
		PlayerStats.refill()
		return null
	
	var data =  JSON.parse_string(load_file.get_line())
	WorldStash.data = data
	
	var file_path = WorldStash.retrieve("level", "file_path")
	MainInstances.world.load_level(file_path)
	
	MainInstances.retrieve_stats()
	PlayerStats.retrieve_stats()
	load_file.close()
