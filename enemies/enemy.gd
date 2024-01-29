class_name Enemy
extends Node

func check_freed(root):
	if WorldStash.is_freed(root):
		root.queue_free()


func killed(root):
	WorldStash.freed(root)
	root.queue_free()


