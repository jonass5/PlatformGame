class_name GameOverMenu
extends ColorRect

@onready var load_button = $CenterContainer/VBoxContainer/LoadButton


func _ready():
	load_button.grab_focus()


func _on_load_button_pressed():
	Sound.play(Sound.click, 1.0, -10.0)
	SaveManager.loading = true
	get_tree().change_scene_to_file("res://world/world.tscn")


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://menus/start_menu.tscn")
