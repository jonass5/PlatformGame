class_name Hurtbox
extends Area2D

signal hurt(hitbox, damage)

var is_invincible: bool = false:
	set(value):
		is_invincible = value
		disable.call_deferred(value)


func take_hit(hitbox: Hitbox, damage: int) -> void:
	if is_invincible:
		return
	hurt.emit(hitbox, damage)


func disable(value: bool) -> void:
	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.disabled = value
