class_name MissilePowerup
extends Powerup

var number_of_missiles: int = 3


func pickup():
	super()
	PlayerStats.max_missiles += number_of_missiles
	PlayerStats.missiles += number_of_missiles
