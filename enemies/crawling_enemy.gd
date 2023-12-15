extends Node2D
class_name CrawlingEnemy

const EnemyDeathEffectScene = preload("res://effects/enemy_death_effect.tscn")

enum DIRECTON { LEFT = -1, RIGHT = 1}

@export var crawling_direction : DIRECTON = DIRECTON.RIGHT
@export var max_speed : float = 200.0

@onready var floor_cast = $FloorCast
@onready var wall_cast = $WallCast
@onready var stats : Stats = $Stats as Stats

func _ready() -> void:
	wall_cast.target_position.x *= crawling_direction

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) -> void:
	if wall_cast.is_colliding():
		global_position = wall_cast.get_collision_point()
		var wall_normal = wall_cast.get_collision_normal()
		rotation = wall_normal.rotated(deg_to_rad(90)).angle()
	else:
		floor_cast.rotation_degrees = -max_speed * crawling_direction * delta
		if floor_cast.is_colliding():
			global_position = floor_cast.get_collision_point()
			var floor_normal = floor_cast.get_collision_normal()
			rotation = floor_normal.rotated(deg_to_rad(90)).angle()
		else:
			rotation_degrees += crawling_direction


func _on_hurtbox_hurt(hitbox, damage) -> void:
	stats.health -= damage


func _on_stats_no_health() -> void:
	queue_free()
	Utils.instanciate_scene_on_world(EnemyDeathEffectScene, global_position)
