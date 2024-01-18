class_name PlayerChar
extends CharacterBody2D

const DustEffectScene = preload("res://effects/dust_effect.tscn")
const JumpEffectScene = preload("res://effects/jump_effect.tscn")
const WallJumpEffectScene = preload("res://effects/wall_jump_effect.tscn")

@export var acceleration = 512
@export var max_velocity = 64
@export var friction = 256
@export var air_friction = 64
@export var gravity = 200
@export var jump_force = 128
@export var max_fall_velocity = 128
@export var wall_slide_speed = 42
@export var max_wall_slide_speed = 128

var air_jump : bool = false
var state : Callable = move_state

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer
@onready var player_blaster = $PlayerBlaster
@onready var fire_rate_timer = $FireRateTimer
@onready var drop_timer = $DropTimer
@onready var camera_2d = $Camera2D
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var blinking_animation_player = $BlinkingAnimationPlayer
@onready var center = $Center


func _ready():
	PlayerStats.no_health.connect(die)


func _enter_tree():
	MainInstances.player = self


func _physics_process(delta: float) -> void:
	state.call(delta)

	if Input.is_action_pressed("fire") and fire_rate_timer.time_left == 0:
		fire_rate_timer.start()
		player_blaster.fire_bullet()

	if (Input.is_action_pressed("fire_missile")
	and fire_rate_timer.time_left == 0
	and PlayerStats.missiles > 0):
		fire_rate_timer.start()
		player_blaster.fire_missile()
		PlayerStats.missiles -= 1


func _exit_tree():
	MainInstances.player = null

func move_state(delta: float) -> void:
	apply_gravity(delta)

	var input_axis = Input.get_axis("move_left", "move_right")

	if is_moving(input_axis):
		apply_acceleration(delta, input_axis)
	else:
		apply_friction(delta)

	jump_check()

	if Input.is_action_just_pressed("crouch"):
		set_collision_mask_value(2, false)
		drop_timer.start()

	update_animation(input_axis)

	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_edge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_edge:
		coyote_jump_timer.start()
	wall_check()


func wall_slide_state(delta: float) -> void:
	var wall_normal = get_wall_normal()
	animation_player.play("wall_slide")
	sprite_2d.scale.x = sign(wall_normal.x)
	velocity.y = clampf(velocity.y, -max_wall_slide_speed / 2.0, max_wall_slide_speed)
	wall_jump_check(wall_normal.x)
	apply_wall_slide_gravity(delta)
	move_and_slide()
	wall_detach(delta, wall_normal.x)


func wall_check() -> void:
	if not is_on_floor() and is_on_wall():
		state = wall_slide_state
		air_jump = true
		create_dust_effect()


func wall_detach(delta: float, wall_axis: int) -> void:
	if Input.is_action_just_pressed("move_right") and wall_axis == 1:
		velocity.y = acceleration * delta
		state = move_state

	if Input.is_action_just_pressed("move_left") and wall_axis == -1:
		velocity.x = acceleration * delta
		state = move_state

	if not is_on_wall() or is_on_floor():
		state = move_state


func wall_jump_check(wall_axis) -> void:
	if Input.is_action_just_pressed("jump"):
		Sound.play(Sound.jump, randf_range(0.8, 1.1), -5.0)
		velocity.x = wall_axis * max_velocity
		state = move_state
		jump(jump_force * 0.75, false)
		var wall_jump_effect_position = global_position + Vector2(wall_axis * 3.5, -2)
		var wall_jump_effect = Utils.instanciate_scene_on_world(WallJumpEffectScene, wall_jump_effect_position)
		wall_jump_effect.scale.x = wall_axis


func apply_wall_slide_gravity(delta) -> void:
	var slide_speed = wall_slide_speed

	if Input.is_action_pressed("crouch"):
		slide_speed = max_wall_slide_speed

	velocity.y = move_toward(velocity.y, slide_speed, gravity * delta)


func create_dust_effect() -> void:
	Sound.play(Sound.step, randf_range(0.8, 1.1), -5.0)
	Utils.instanciate_scene_on_world(DustEffectScene, global_position)


func is_moving(input_axis: float) -> bool:
	return input_axis != 0


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y = move_toward(velocity.y, max_fall_velocity, gravity * delta)


func apply_acceleration(delta: float, input_axis: float) -> void:
	if is_moving(input_axis):
		velocity.x = move_toward(velocity.x, input_axis * max_velocity, acceleration * delta)


func apply_friction(delta: float) -> void:
	if is_on_floor():
		velocity.x = move_toward(velocity.x, 0, friction * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, air_friction * delta)


func jump_check() -> void:
	if is_on_floor():
		air_jump = true

	if  is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("jump"):
			jump(jump_force)
	if not is_on_floor():
		if Input.is_action_just_released("jump") and velocity.y < -jump_force / 2.0:
			velocity.y = -jump_force / 2.0

		if Input.is_action_just_pressed("jump") and air_jump:
			jump(jump_force * 0.75)
			air_jump = false


func jump(force: float, create_effect: bool = true) -> void:
	Sound.play(Sound.jump, randf_range(0.8, 1.1), 5.0)
	velocity.y = -force
	if create_effect:
		Utils.instanciate_scene_on_world(JumpEffectScene, global_position)

func update_animation(input_axis: float) -> void:
	if Input.get_connected_joypads().is_empty():
		sprite_2d.scale.x = sign(get_local_mouse_position().x)
	else:
		sprite_2d.scale.x = sign(player_blaster.get_blaster_direction())

	if abs(sprite_2d.scale.x) != 1:
		sprite_2d.scale.x = 1

	if is_moving(input_axis):
		animation_player.play("run")
		animation_player.speed_scale = input_axis * sprite_2d.scale.x
	else:
		animation_player.play("idle")

	if not is_on_floor():
		animation_player.play("jump")


func die():
	camera_2d.reparent(get_tree().current_scene)
	queue_free()


func _on_drop_timer_timeout():
	set_collision_mask_value(2, true)


func _on_hurtbox_hurt(_hitbox, _damage):
	hurt()
	hurtbox.is_invincible = true
	blinking_animation_player.play("blink")
	await blinking_animation_player.animation_finished
	hurtbox.is_invincible = false


func hurt():
	Sound.play(Sound.hurt)
	Events.add_screenshake.emit(10, 0.1)
	PlayerStats.health -= 1
