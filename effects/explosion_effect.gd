class_name ExplosionEffect
extends Effect

func _ready():
	super()
	Sound.play_with_distance(Sound.explosion, global_position)
