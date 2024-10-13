class_name OpeningScene
extends Node2D


func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("OpeningScene")


func _on_dialogic_signal(argument:String):
	if argument == "opening_scene_start_game":
		get_tree().change_scene_to_file("res://world/world.tscn")
	elif argument == "opening_scene_menu":
		get_tree().change_scene_to_file("res://menus/start_gui.tscn")


func _on_timeline_ended():
	Sound.play(Sound.click, 1.0, -10.0)


func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().change_scene_to_file("res://world/world.tscn")
		Dialogic.end_timeline()
