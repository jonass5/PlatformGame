extends Node

const TEST_PATH: String = "res://save.txt"
const PROD_PATH: String = "user://platform_game_save.save"

var save_path: String = PROD_PATH
var is_loading: bool = false


func save_game():
	WorldStash.stash("level", "file_path", MainInstances.level.scene_file_path)
	WorldStash.stash("player", "x", MainInstances.player.global_position.x)
	WorldStash.stash("player", "y", MainInstances.player.global_position.y)
	
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	var data_string = JSON.stringify(WorldStash.data)
	save_file.store_string(data_string)
	save_file.close()


func load_game():
	var save_file = FileAccess.open(save_path, FileAccess.READ)
	if not save_file is FileAccess:
		return null
	
	var data =  JSON.parse_string(save_file.get_line())
	WorldStash.data = data
	
	var file_path = WorldStash.retrive("level", "file_path")
	MainInstances.world.load_level(file_path)
	
	var player_x = WorldStash.retrive("player", "x")
	var player_y = WorldStash.retrive("player", "y")
	MainInstances.player.global_position = Vector2(player_x, player_y)
	
	save_file.close()
