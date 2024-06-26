class_name OpeningScene
extends Node2D


func _ready():
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("OpeningScene")

func _on_dialogic_signal(argument:String):
	if argument == "end_scene_one":
		Sound.play(Sound.click, 1.0, -10.0)
		get_tree().change_scene_to_file("res://world/world.tscn")
