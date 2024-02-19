class_name MissilePowerup
extends Powerup

@export var number_of_missiles: int = 3


func pickup():
	super()
	PlayerStats.max_missiles += number_of_missiles
	PlayerStats.missiles += number_of_missiles
