class_name WalkingEnemy
extends CharacterBody2D

const EnemyDeathEffectScene = preload("res://effects/enemy_death_effect.tscn")

const FACING_RIGHT = 1.0
const FACING_LEFT = -1.0

@export var speed: float = 20.0
@export var turns_on_ledges: bool = true

var gravity: float = 200.0
var direction: float = FACING_RIGHT

@onready var sprite_2d = $Sprite2D
@onready var floor_cast = $FloorCast
@onready var back_cast = $BackCast
@onready var stats = $Stats
@onready var death_effect_location = $DeathEffectLocation
@onready var enemy_health_bar = $EnemyHealthBar
@onready var enemy = $Enemy


func _ready() -> void:
	enemy.init(self)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if is_player_in_back():
		turn_around()

	if is_on_wall():
		turn_around()

	if is_on_ledge() and turns_on_ledges:
		turn_around()

	velocity.x = direction * speed
	sprite_2d.flip_h = direction == FACING_RIGHT

	move_and_slide()


func is_player_in_back() -> bool:
	return back_cast.is_colliding()


func is_on_ledge() -> bool:
	return is_on_floor() and not floor_cast.is_colliding()


func turn_around() -> void:
	direction *= -1.0
	if direction == FACING_RIGHT:
		back_cast.rotation_degrees = 0
	else:
		back_cast.rotation_degrees = 180



func _on_hurtbox_hurt(_hitbox, damage):
	stats.health -= damage
	enemy.hurt(self)


func _on_stats_no_health():
	enemy.no_health(self)
	Utils.instanciate_scene_on_level(EnemyDeathEffectScene, death_effect_location.global_position)
