class_name Enemy
extends Node

@onready var parent = get_parent()


func _ready():
	if WorldStash.is_freed(parent):
		parent.queue_free()


func killed():
	WorldStash.freed(parent)
	parent.queue_free()


