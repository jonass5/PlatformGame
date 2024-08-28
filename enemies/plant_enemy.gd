class_name PlantEnemy
extends Node2D

const EnemyDeathEffectScene = preload("res://effects/enemy_death_effect.tscn")
const EnemyBulletScene = preload("res://enemies/enemy_bullet.tscn")

@export var bullet_speed = 30
@export var spread = 45
@export var shoot_when_on_screen = true

@onready var stats = $Stats
@onready var bullet_spawn_point = $BulletSpawnPoint
@onready var fire_direction = $FireDirection
@onready var enemy_health_bar = $EnemyHealthBar
@onready var enemy = $Enemy
@onready var visible_on_screen_enabler_2d = $VisibleOnScreenEnabler2D


func _ready():
	enemy.init(self)
	if not shoot_when_on_screen:
		visible_on_screen_enabler_2d.queue_free()
		process_mode = Node.PROCESS_MODE_INHERIT


func fire_bullet():
	var bullet = Utils.instanciate_scene_on_level(EnemyBulletScene, bullet_spawn_point.global_position) as Projectile
	var direction = global_position.direction_to(fire_direction.global_position)
	var velocity = direction.normalized() * bullet_speed
	velocity = velocity.rotated(randf_range(-deg_to_rad(spread / 2.0), deg_to_rad(spread / 2.0)))
	bullet.velocity = velocity


func _on_stats_no_health():
	enemy.no_health(self)
	Utils.instanciate_scene_on_level(EnemyDeathEffectScene, bullet_spawn_point.global_position)


func _on_hurtbox_hurt(_hitbox, damage: int):
	stats.health -= damage
	enemy.hurt(self)
