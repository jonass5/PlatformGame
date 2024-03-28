class_name Door
extends Area2D

enum DoorType { VERTICAL, HORIZONTAL }

const MAX_DOOR_HEIGHT = 16

@export_file("*.tscn") var new_level_path
@export var connection: DoorConnection
@export var door_type: DoorType = DoorType.VERTICAL

var active = false

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


func get_yoffset(player_global_position_y: float) -> float:
	var yoffset = 0
	if door_type == Door.DoorType.VERTICAL:
		yoffset = max(player_global_position_y - global_position.y, -MAX_DOOR_HEIGHT)
	else:
		yoffset = -max(player_global_position_y - global_position.y, -MAX_DOOR_HEIGHT)
	return yoffset
