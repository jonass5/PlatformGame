class_name HealthMeter
extends Control

@onready var empty = $Empty
@onready var full = $Full

func _ready():
	update_health_ui()
	update_max_health_ui()
	PlayerStats.health_changed.connect(update_health_ui)
	PlayerStats.max_health_changed.connect(update_max_health_ui)
	
	
func update_health_ui():
	full.size.x = PlayerStats.health * 10 + 2

func update_max_health_ui():
	empty.size.x = PlayerStats.max_health * 10 + 2
	
