class_name MissilePowerup
extends Powerup

var number_of_missiles: int = 3


func pickup():
	super()
	PlayerStats.set_max_missiles(PlayerStats.max_missiles + number_of_missiles)
	PlayerStats.set_missiles(PlayerStats.missiles + number_of_missiles)
