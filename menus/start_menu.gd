class_name StartMenu
extends ColorRect

@onready var quit_game = $CenterContainer/VBoxContainer/QuitGame


func _ready():
	if OS.get_name() == "Web":
		quit_game.hide()


func _on_start_gane_pressed():
	get_tree().change_scene_to_file("res://world.tscn")


func _on_load_game_pressed():
	print("load save game")


func _on_quit_game_pressed():
	get_tree().quit()
