class_name Powerup
extends Area2D


func _ready():
	if WorldStash.is_freed(self):
		queue_free()


func pickup():
	Sound.play(Sound.powerup)
	WorldStash.freed(self)
	queue_free()


func _on_body_entered(_body):
	pickup()
