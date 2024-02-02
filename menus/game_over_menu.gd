class_name GameOverMenu
extends ColorRect

@onready var load_button = $CenterContainer/VBoxContainer/LoadButton
@onready var quit_button = $CenterContainer/VBoxContainer/QuitButton


func _ready():
	if OS.get_name() == "Web":
		quit_button.hide()
	load_button.grab_focus()


func _on_load_button_pressed():
	Sound.play(Sound.click, 1.0, -10.0)
	SaveManager.loading = true
	get_tree().change_scene_to_file("res://world.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
