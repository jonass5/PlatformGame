class_name Level04Tutorial
extends Level

@onready var start_marker = $StartMarker



func _on_trigger_trigger_entered():
	var player = MainInstances.player
	player.global_position = start_marker.global_position
