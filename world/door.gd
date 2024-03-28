class_name Door
extends Area2D

enum DoorType { VERTICAL, HORIZONTAL }

const MAX_DOOR_HEIGHT = 16

@export_file("*.tscn") var new_level_path
@export var connection: DoorConnection

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
		var player_direction = get_player_direction(player)
		var door_direction = get_direction()
		if (player_direction == door_direction):
			Events.door_entered.emit(self)


func get_player_direction(player: Player) -> int:
	return sign(player.velocity.x)
	

func get_direction() -> int:
	if left_cast.is_colliding():
		return -1
	if right_cast.is_colliding():
		return 1
	return 0


func get_yoffset(player_global_position_y: float, door_global_position_y: float) -> float:
	return max(player_global_position_y - door_global_position_y, -MAX_DOOR_HEIGHT)


func _on_timer_timeout():
	active = true

