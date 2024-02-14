class_name Brick
extends StaticBody2D


func _ready():
	if WorldStash.is_freed(self):
		queue_free()
	update_collision_layer()


func update_collision_layer():
	set_collision_layer_value(1, is_visible_in_tree())


func _on_visibility_changed():
	update_collision_layer()


func destroy():
	WorldStash.freed(self)
	queue_free()
