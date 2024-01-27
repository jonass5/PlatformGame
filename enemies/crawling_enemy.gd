class_name CrawlingEnemy
extends Node2D

const EnemyDeathEffectScene = preload("res://effects/enemy_death_effect.tscn")

enum DIRECTON { LEFT = -1, RIGHT = 1}

@export var crawling_direction : DIRECTON = DIRECTON.RIGHT
@export var max_speed : float = 200.0
@export var spin_speed : float = 600.0

var state = crawling_state
var gravity = 100

@onready var floor_cast = $FloorCast
@onready var wall_cast = $WallCast
@onready var stats : Stats = $Stats as Stats
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var enemy_health_bar = $EnemyHealthBar


func _ready() -> void:
	wall_cast.target_position.x *= crawling_direction
	enemy_health_bar.max_value = stats.max_health
	enemy_health_bar.value = stats.health


func _physics_process(delta) -> void:
	state.call(delta)


func crawling_state(delta) -> void:
	animated_sprite_2d.play("crawl")
	if wall_cast.is_colliding():
		global_position = wall_cast.get_collision_point()
		var wall_normal = wall_cast.get_collision_normal()
		rotation = wall_normal.rotated(deg_to_rad(90)).angle()
	else:
		floor_cast.rotation_degrees = -max_speed * crawling_direction * delta
		
		var while_limit = 30
		while not floor_cast.is_colliding():
			rotation_degrees += crawling_direction
			floor_cast.force_raycast_update()
			while_limit -= 1
			if while_limit <= 0:
				state = falling_state
				break
							
		if floor_cast.is_colliding():
			global_position = floor_cast.get_collision_point()
			var floor_normal = floor_cast.get_collision_normal()
			rotation = floor_normal.rotated(deg_to_rad(90)).angle()


func falling_state(delta):
	animated_sprite_2d.play("fall")
	rotation_degrees += crawling_direction * spin_speed * delta
	position.y += gravity * delta
	
	if floor_cast.is_colliding() or wall_cast.is_colliding():
		state = crawling_state


func _on_hurtbox_hurt(_hitbox, damage: int) -> void:
	stats.health -= damage
	enemy_health_bar.value = stats.health


func _on_stats_no_health() -> void:
	queue_free()
	Utils.instanciate_scene_on_world(EnemyDeathEffectScene, global_position)
