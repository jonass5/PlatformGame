class_name Menu
extends ColorRect

signal menu_changed(menu_name: Name)
signal menu_closed()

enum Name { start_menu, settings_menu, controls_menu, pause_menu, default_menu }
