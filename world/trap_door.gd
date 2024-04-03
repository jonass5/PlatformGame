class_name TrapDoor
extends Door

func get_player_direction(player: Player) -> int:
	return sign(player.velocity.y)
	

func get_direction() -> int:
	if up_cast.is_colliding():
		return -1
	if down_cast.is_colliding():
		return 1
	return 0


func get_yoffset(player_global_position_y: float, door_global_position_y: float) -> float:
	return -max(player_global_position_y - door_global_position_y, -MAX_DOOR_HEIGHT)
