class_name Teleport
extends Area2D

const TeleportEffectScene = preload("res://effects/teleport_effect.tscn")

@export_file("*.tscn") var new_level_path


func _on_body_entered(body):
	if body is Player:
		MainInstances.world.load_level(new_level_path)
		var targets = get_tree().get_nodes_in_group("teleport")
		body.global_position = targets[0].global_position
		Utils.instanciate_scene_on_level(TeleportEffectScene, body.global_position + Vector2(0, -8))

