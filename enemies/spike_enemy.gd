class_name SpikeEnemy
extends StaticBody2D


func _ready():
	if WorldStash.is_freed(self):
		queue_free()


func _on_missile_hit():
	WorldStash.freed(self)
	queue_free()
