class_name PauseMenu
extends ColorRect



var paused = false :
	set(value):
		paused = value
		get_tree().paused = paused
		visible = paused
		if paused:
			Sound.play(Sound.pause, 1.0, -10.0)
		else:
			Sound.play(Sound.unpause, 1.0, -10.0)

@onready var quit_button = $CenterContainer/VBoxContainer/QuitButton
@onready var resume_button = $CenterContainer/VBoxContainer/ResumeButton


func _ready():
	if OS.get_name() == "Web":
		quit_button.hide()


func _process(_delta):
	if not MainInstances.player is Player:
		return
	if Input.is_action_just_pressed("pause"):
		paused = !paused
		resume_button.grab_focus()


func _on_resume_button_pressed():
	paused = false
	Sound.play(Sound.click, 1.0, -10.0)


func _on_menu_button_pressed():
	WorldStash.data = {}
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menus/start_menu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


