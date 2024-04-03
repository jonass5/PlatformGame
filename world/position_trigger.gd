class_name PositionTrigger
extends Area2D

@onready var target_position = $TargetPosition


func _on_body_entered(body):
	if body is Player:
		body.global_position = target_position.global_position
