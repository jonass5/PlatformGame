class_name Stats
extends Node


@export var max_health = 3 : set = set_max_health
@onready var health = max_health : set = set_health

signal no_health


func set_max_health(value: int) -> void:
	max_health = value


func set_health(value: int) -> void:
	health = clamp(value, 0, max_health)

	if(health <= 0):
		no_health.emit()
