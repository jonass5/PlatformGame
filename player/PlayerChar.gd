class_name PlayerChar
extends CharacterBody2D

const DustEffectScene = preload("res://effects/dust_effect.tscn")

@export var acceleration = 512
@export var max_velocity = 64
@export var friction = 256
@export var gravity = 200
@export var jump_force = 128
@export var max_fall_velocity = 128

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	
	var input_axis = Input.get_axis("ui_left", "ui_right")
	
	if is_moving(input_axis):
		apply_acceleration(delta, input_axis)
	else:
		apply_friction(delta)
	
	jump_check()
	update_animation(input_axis)
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_edge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_edge:
		coyote_jump_timer.start()


func create_dust_effect() -> void:
	var dust_effect = DustEffectScene.instantiate()
	var main = get_tree().current_scene
	main.add_child(dust_effect)
	dust_effect.global_position = global_position


func is_moving(input_axis: float) -> bool:
	return input_axis != 0


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y = move_toward(velocity.y, max_fall_velocity, gravity * delta)


func apply_acceleration(delta: float, input_axis: float) -> void:
	if is_moving(input_axis):
		velocity.x = move_toward(velocity.x, input_axis * max_velocity, acceleration * delta)


func apply_friction(delta: float) -> void:
	velocity.x = move_toward(velocity.x, 0, friction * delta)


func jump_check() -> void:
	if  is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -jump_force
	if not is_on_floor():
		if Input.is_action_just_released("ui_up") and velocity.y < -jump_force / 2.0:
			velocity.y = -jump_force / 2.0


func update_animation(input_axis: float) -> void:
	if is_moving(input_axis):
		animation_player.play("run")
		sprite_2d.scale.x = sign(input_axis)
	else:
		animation_player.play("idle")
	
	if not is_on_floor():
		animation_player.play("jump")

