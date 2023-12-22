class_name MissleUI
extends HBoxContainer

@onready var label = $Label


func _ready():
	update_missle_label()
	PlayerStats.missles_changed.connect(update_missle_label)


func update_missle_label():
	label.text = str(PlayerStats.missiles)

