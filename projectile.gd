class_name Projectile
extends Node2D

const ExplosionEffectScene = preload("res://effects/explosion_effect.tscn")

@export var speed = 200

var velocity = Vector2.ZERO


func _ready():
	Sound.play(Sound.bullet, randf_range(0.6, 1.2))


func update_velocity():
	velocity.x = speed
	velocity = velocity.rotated(rotation)


func _process(delta: float):
	position += velocity * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_hitbox_body_entered(_body):
	Utils.instanciate_scene_on_world(ExplosionEffectScene, global_position)
	queue_free()

func _on_hitbox_area_entered(_area):
	Utils.instanciate_scene_on_world(ExplosionEffectScene, global_position)
	queue_free()
