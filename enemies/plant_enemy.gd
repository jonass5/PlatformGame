class_name PlantEnemy
extends Node2D

const EnemyDeathEffectScene = preload("res://effects/enemy_death_effect.tscn")
const EnemyBulletScene = preload("res://enemies/enemy_bullet.tscn")

@export var bullet_speed = 30
@export var spread = 45

@onready var stats = $Stats
@onready var bullet_spawn_point = $BulletSpawnPoint
@onready var fire_direction = $FireDirection
@onready var enemy_health_bar = $EnemyHealthBar

func _ready():
	enemy_health_bar.max_value = stats.max_health
	enemy_health_bar.value = stats.health


func fire_bullet():
	var bullet = Utils.instanciate_scene_on_world(EnemyBulletScene, bullet_spawn_point.global_position) as Projectile
	var direction = global_position.direction_to(fire_direction.global_position)
	var velocity = direction.normalized() * bullet_speed
	velocity = velocity.rotated(randf_range(-deg_to_rad(spread / 2.0), deg_to_rad(spread / 2.0)))
	bullet.velocity = velocity


func _on_stats_no_health():
	Utils.instanciate_scene_on_world(EnemyDeathEffectScene, bullet_spawn_point.global_position)
	queue_free()


func _on_hurtbox_hurt(_hitbox, damage: int):
	stats.health -= damage
	enemy_health_bar.value = stats.health
