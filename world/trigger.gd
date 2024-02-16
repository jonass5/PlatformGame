class_name Trigger
extends Area2D

var active: bool = true

signal trigger_entered


func _on_body_entered(_body):
	if not active:
		return
	trigger_entered.emit()
