class_name World
extends Node2D

@onready var level = $Level01


func _enter_tree():
	MainInstances.world = self


func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	Events.door_entered.connect(change_levels)
	Events.player_died.connect(game_over)
	Music.play(Music.main_theme)
	if SaveManager.loading:
		SaveManager.load_game()
		SaveManager.loading = false


func _exit_tree():
	MainInstances.world = null


func load_level(file_path: String):
	level.queue_free()
	level.name = level.name + "OLD"
	var LevelScene = load(file_path)
	var new_level = LevelScene.instantiate()
	add_child(new_level)
	level = new_level


func change_levels(door: Door):
	var player = MainInstances.player as Player
	if not player is Player:
		return
	var old_level_path = level.scene_file_path
	level.queue_free()
	level = load_new_level(door)
	player.global_position = position_player(door, old_level_path, player.global_position)


func load_new_level(door: Door) -> Level:
	var new_level = load(door.new_level_path).instantiate()
	add_child(new_level)
	return new_level


func position_player(door: Door, old_level_path: String, player_global_position: Vector2) -> Vector2:
	var doors = get_tree().get_nodes_in_group("doors")
	var found_door = find_door(doors, door, old_level_path)
	var yoffset = found_door.get_yoffset(player_global_position.y, door.global_position.y)
	return found_door.global_position + Vector2(0, yoffset)
	
	
func find_door(doors: Array[Node], door: Door, old_level_path: String) -> Door:
	for found_door in doors:
		if found_door == door: continue
		if found_door.new_level_path != old_level_path: continue
		if door.connection != null and found_door.connection != null && found_door.connection != door.connection: continue
		return found_door
		
	return door


func game_over():
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://menus/game_over_menu.tscn")
