class_name ExplosionEffect
extends Effect

func _ready():
	super()
	var distance = global_position.distance_to(MainInstances.player.global_position)
	var viewport_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	var volume_cluster = round(distance / viewport_width)
	if volume_cluster == 0:
		Sound.play(Sound.explosion, 1.0)
	elif volume_cluster == 1:
		Sound.play(Sound.explosion, 1.0, -5.0)
	elif volume_cluster == 2:
		Sound.play(Sound.explosion, 1.0, -10.0)
	elif volume_cluster == 3:
		Sound.play(Sound.explosion, 1.0, -20.0)


