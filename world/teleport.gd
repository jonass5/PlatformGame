class_name Teleport
extends Area2D

@export_file("*.tscn") var new_level_path

func _on_body_entered(body):
	if body is Player:
		MainInstances.world.load_level(new_level_path)
		var targets = get_tree().get_nodes_in_group("teleport")
		body.global_position = targets[0].global_position

