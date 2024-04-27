class_name StartGui
extends Node

@onready var start_menu = $StartMenu
@onready var setting_menu = $SettingMenu
@onready var controls_menu = $ControlsMenu


func _on_menu_changed(menu_name):
	Sound.play(Sound.click, 1.0, -10.0)
	hide_menus()
	show_menu(menu_name)


func hide_menus() -> void:
	start_menu.hide()
	setting_menu.hide()
	controls_menu.hide()


func show_menu(menu_name: Menu.Name) -> void:
	match menu_name:
		Menu.Name.settings_menu:
			setting_menu.show()
		Menu.Name.controls_menu:
			controls_menu.show()
		_:
			start_menu.show()

