class_name WalkingEnemy
extends CharacterBody2D

@export var speed: float = 30.0
@export var turns_on_ledges: bool = true

var gravity: float = 200.0
var direction: float = 1.0

@onready var sprite_2d = $Sprite2D
@onready var floor_cast = $FloorCast
@onready var stats = $Stats

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if is_on_wall():
		turn_around()

	if is_on_ledge() and turns_on_ledges:
		turn_around()

	velocity.x = direction * speed
	sprite_2d.scale.x = direction

	move_and_slide()


func is_on_ledge() -> bool:
	return is_on_floor() and not floor_cast.is_colliding()


func turn_around() -> void:
	direction *= -1.0
	
	
func _on_hurtbox_hurt(_hitbox, damage):
	stats.health -= damage


func _on_stats_no_health():
	queue_free()
