class_name PlantEnemy
extends Node2D

const EnemyBulletScene = preload("res://enemies/enemy_bullet.tscn")

@export var bullet_speed = 30
@export var spread = 30

@onready var stats = $Stats
@onready var bullet_spawn_point = $BulletSpawnPoint
@onready var fire_direction = $FireDirection


func fire_bullet():
	var bullet = Utils.instanciate_scene_on_world(EnemyBulletScene, bullet_spawn_point.global_position) as Projectile
	var direction = global_position.direction_to(fire_direction.global_position)
	bullet.rotation = direction.angle()
	bullet.rotate(randf_range(-deg_to_rad(spread/2), deg_to_rad(spread/2)))
	bullet.speed = bullet_speed
	bullet.update_velocity()


func _on_stats_no_health():
	queue_free()


func _on_hurtbox_hurt(_hitbox, damage: int):
	stats.health -= damage
