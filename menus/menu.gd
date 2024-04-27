class_name Menu
extends ColorRect

signal menu_changed(menu_name: Name)

enum Name { start_menu, settings_menu, controls_menu, pause_menu, default_menu }
