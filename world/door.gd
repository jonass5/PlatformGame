class_name Door
extends Area2D

@export_file("*.tscn") var new_level_path
@export var connection: DoorConnection

var active = false

@onready var right_cast = $RightCast
@onready var left_cast = $LeftCast


func _physics_process(_delta: float):
	var player = MainInstances.player as PlayerChar
	if not player is PlayerChar:
		return
	if not active:
		return
	if overlaps_body(player) and new_level_path:
		var player_direction = sign(player.velocity.x)
		var door_direction = get_direction()
		if (player_direction == door_direction):
			Events.door_entered.emit(self)


func get_direction():
	if left_cast.is_colliding():
		return -1
	if right_cast.is_colliding():
		return 1
	return 0


func _on_timer_timeout():
	active = true
