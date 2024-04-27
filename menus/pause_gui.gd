class_name PauseGui
extends Node

@onready var pause_menu = $PauseMenu
@onready var settings_menu = $SettingsMenu


var paused = false:
	set(value):
		paused = value
		get_tree().paused = paused
		if paused:
			Sound.play(Sound.pause, 1.0, -10.0)
			show_menu(Menu.Name.pause_menu)
		else:
			Sound.play(Sound.unpause, 1.0, -10.0)


func _process(_delta):
	if not MainInstances.player is Player:
		return
	if Input.is_action_just_pressed("pause"):
		paused = !paused


func _on_menu_changed(menu_name):
	Sound.play(Sound.click, 1.0, -10.0)
	hide_menus()
	show_menu(menu_name)


func hide_menus() -> void:
	pause_menu.hide()
	settings_menu.hide()


func show_menu(menu_name: Menu.Name) -> void:
	match menu_name:
		Menu.Name.pause_menu:
			pause_menu.show()
		Menu.Name.settings_menu:
			settings_menu.show()
		_:
			hide_menus()
			paused = false

