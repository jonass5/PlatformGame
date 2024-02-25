class_name SettingsMenu
extends ColorRect


func _on_button_pressed():
	Sound.play(Sound.click, 1.0, -10.0)
	get_tree().change_scene_to_file("res://menus/start_menu.tscn")
