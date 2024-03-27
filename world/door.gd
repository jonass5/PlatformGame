class_name Door
extends Area2D

@export_file("*.tscn") var new_level_path
@export var connection: DoorConnection
@export var door_type: DoorType = DoorType.VERTICAL

var active = false

enum DoorType { VERTICAL, HORIZONTAL }

@onready var right_cast = $RightCast
@onready var left_cast = $LeftCast
@onready var down_cast = $DownCast
@onready var up_cast = $UpCast


func _physics_process(_delta: float):
	var player = MainInstances.player as Player
	if not player is Player:
		return
	if not active:
		return
	if overlaps_body(player) and new_level_path:
		var player_direction
		if door_type == DoorType.VERTICAL:
			player_direction = sign(player.velocity.x)
		else:
			player_direction = sign(player.velocity.y)
		var door_direction = get_direction()
		if (player_direction == door_direction):
			Events.door_entered.emit(self)


func get_direction():
	if door_type == DoorType.VERTICAL:
		if left_cast.is_colliding():
			return -1
		if right_cast.is_colliding():
			return 1
	else:
		if up_cast.is_colliding():
			return -1
		if down_cast.is_colliding():
			return 1
	return 0


func _on_timer_timeout():
	active = true
