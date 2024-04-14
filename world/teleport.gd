class_name Teleport
extends Area2D

const TeleportEffectScene = preload("res://effects/teleport_effect.tscn")
const OFFSET = Vector2(0, -8)

@export_file("*.tscn") var new_level_path


func _on_body_entered(body):
	if body is Player:
		teleport.call_deferred(body)
		#MainInstances.world.load_level.call_deferred(new_level_path)
		#var targets = get_tree().get_nodes_in_group("teleport")
		#if not targets.is_empty():
			#body.global_position = targets[0].global_position
			#Utils.instanciate_scene_on_level(TeleportEffectScene, body.global_position + OFFSET)


func teleport(body):
		MainInstances.world.load_level(new_level_path)
		var targets = get_tree().get_nodes_in_group("teleport")
		if not targets.is_empty():
			body.global_position = targets[0].global_position
			Utils.instanciate_scene_on_level(TeleportEffectScene, body.global_position + OFFSET)

