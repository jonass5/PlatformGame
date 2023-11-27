class_name Void
extends Area2D


func _on_body_exited(body):
	if body is PlayerChar:
		body.reached_void()
