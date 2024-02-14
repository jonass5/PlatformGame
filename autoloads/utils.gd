extends Node

func instanciate_scene_on_world(scene: PackedScene, position: Vector2):
	var instance = scene.instantiate()
	get_tree().current_scene.add_child.call_deferred(instance)
	instance.global_position = position
	return instance
	
	
func instanciate_scene_on_level(scene: PackedScene, position: Vector2):
	var instance = scene.instantiate()
	MainInstances.level.add_child.call_deferred(instance)
	instance.global_position = position
	return instance

