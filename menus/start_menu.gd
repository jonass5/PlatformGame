class_name StartMenu
extends ColorRect

@onready var start_button = $CenterContainer/VBoxContainer/StartButton
@onready var quit_button = $CenterContainer/VBoxContainer/QuitButton
@onready var load_button = $CenterContainer/VBoxContainer/LoadButton


func _ready():
	if not SaveManager.is_save_game_available():
		load_button.set_disabled(true)
		
	PlayerStats.reset()
	start_button.grab_focus()
		
	if OS.get_name() == "Web":
		quit_button.hide()


func _on_start_button_pressed():
	Sound.play(Sound.click, 1.0, -10.0)
	get_tree().change_scene_to_file("res://world/world.tscn")


func _on_load_button_pressed():
	Sound.play(Sound.click, 1.0, -10.0)
	SaveManager.loading = true
	get_tree().change_scene_to_file("res://world/world.tscn")


func _on_settings_button_pressed():
	Sound.play(Sound.click, 1.0, -10.0)
	get_tree().change_scene_to_file("res://menus/setting_menu.tscn")


func _on_input_button_pressed():
	Sound.play(Sound.click, 1.0, -10.0)
	get_tree().change_scene_to_file("res://menus/controls_menu.tscn")
	

func _on_quit_button_pressed():
	get_tree().quit()
