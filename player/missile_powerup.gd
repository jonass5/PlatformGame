class_name MissilePowerup
extends Powerup


func pickup():
	super()
	PlayerStats.max_missiles += 3
	PlayerStats.missiles += 3
