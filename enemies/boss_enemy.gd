class_name BossEnemy
extends Node2D

@onready var stats = $Stats


func _process(delta):
	pass


func _on_hurtbox_hurt(hitbox, damage):
	stats.health -= damage


func _on_stats_no_health():
	queue_free()
