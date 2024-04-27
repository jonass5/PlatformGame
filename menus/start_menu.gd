class_name StartMenu
extends Menu

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
	menu_changed.emit(Name.settings_menu)


func _on_controls_button_pressed():
	menu_changed.emit(Name.controls_menu)
	

func _on_quit_button_pressed():
	get_tree().quit()
