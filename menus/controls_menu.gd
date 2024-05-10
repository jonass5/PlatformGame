class_name ControlsMenu
extends Menu


func _on_back_button_pressed():
	menu_changed.emit(Name.default_menu)
