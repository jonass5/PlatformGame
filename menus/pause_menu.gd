class_name PauseMenu
extends Menu


@onready var quit_button = $CenterContainer/VBoxContainer/QuitButton
@onready var resume_button = $CenterContainer/VBoxContainer/ResumeButton


func _ready():
	if OS.get_name() == "Web":
		quit_button.hide()
	resume_button.grab_focus()


func _on_resume_button_pressed():
	menu_closed.emit()


func _on_settings_button_pressed():
	menu_changed.emit(Name.settings_menu)


func _on_menu_button_pressed():
	WorldStash.data = {}
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menus/start_gui.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
