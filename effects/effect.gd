class_name ExplosionEffect
extends AnimatedSprite2D


func _ready():
	animation_finished.connect(queue_free)
	Sound.play(Sound.explosion)

