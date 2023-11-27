class_name Void
extends Area2D

signal reached_void


func _on_body_exited(body):
	self.reached_void.connect(body.reached_void)
	reached_void.emit()
