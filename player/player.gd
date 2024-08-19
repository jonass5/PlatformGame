class_name Player
extends CharacterBody2D

const LAZER_COOL_DOWN_TIME: float = 0.25
const MISSILE_COOL_DOWN_TIME: float = 0.5
const BLASTER_OFFSET = 2

const DustEffectScene = preload("res://effects/dust_effect.tscn")
const JumpEffectScene = preload("res://effects/jump_effect.tscn")
const WallJumpEffectScene = preload("res://effects/wall_jump_effect.tscn")

enum FACING {
	RIGHT = 1,
	LEFT = -1
}

@export var acceleration = 1024
@export var max_velocity = 128
@export var friction = 512
@export var air_friction = 128
@export var gravity = 400
@export var jump_force = 256
@export var max_fall_velocity = 256
@export var wall_slide_speed = 84
@export var max_wall_slide_speed = 256

var air_jump : bool = false
var state : Callable = move_state
var cool_down_time: float = 0.0

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var remote_transform_2d = $Sprite2D/RemoteTransform2D
@onready var coyote_jump_timer = $CoyoteJumpTimer
@onready var player_blaster = $PlayerBlaster
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

	cool_down(delta)
	fire_laser()
	fire_missile()


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
	sprite_2d.flip_h = sign(wall_normal.x) == FACING.LEFT
	velocity.y = clampf(velocity.y, -max_wall_slide_speed / 2.0, max_wall_slide_speed)
	wall_jump_check(wall_normal.x)
	apply_wall_slide_gravity(delta)
	move_and_slide()
	wall_detach(delta, wall_normal.x)


func wall_check() -> void:
	if not is_on_floor() and is_on_wall() and not is_border():
		state = wall_slide_state
		air_jump = true
		create_dust_effect()


func is_border() -> bool:
	var collision = get_last_slide_collision()
	if not collision == null and collision.get_collider() is StaticBody2D:
		return true
	return false
	

func wall_detach(delta: float, wall_axis: int) -> void:
	if Input.is_action_just_pressed("move_right") and wall_axis == FACING.RIGHT:
		velocity.y = acceleration * delta
		state = move_state

	if Input.is_action_just_pressed("move_left") and wall_axis == FACING.LEFT:
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
		var wall_jump_effect = Utils.instanciate_scene_on_level(WallJumpEffectScene, wall_jump_effect_position)
		wall_jump_effect.flip_h = wall_axis == FACING.LEFT


func apply_wall_slide_gravity(delta) -> void:
	var slide_speed = wall_slide_speed

	if Input.is_action_pressed("crouch"):
		slide_speed = max_wall_slide_speed

	velocity.y = move_toward(velocity.y, slide_speed, gravity * delta)


func create_dust_effect() -> void:
	Sound.play(Sound.step, randf_range(0.8, 1.1), -5.0)
	Utils.instanciate_scene_on_level(DustEffectScene, global_position)


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
		Utils.instanciate_scene_on_level(JumpEffectScene, global_position)


func update_animation(input_axis: float) -> void:
	var facing_direction = get_facing_direction()
	sprite_2d.flip_h = facing_direction == FACING.LEFT
	remote_transform_2d.position.x = BLASTER_OFFSET * facing_direction

	if is_moving(input_axis):
		animation_player.play("run")
		animation_player.speed_scale = input_axis * facing_direction
	else:
		animation_player.play("idle")

	if not is_on_floor():
		animation_player.play("jump")


func die():
	camera_2d.reparent(get_tree().current_scene)
	queue_free()
	Events.player_died.emit()


func _on_drop_timer_timeout():
	set_collision_mask_value(2, true)


func _on_hurtbox_hurt(_hitbox, _damage):
	hurt()
	hurtbox.invincible = true
	blinking_animation_player.play("blink")
	await blinking_animation_player.animation_finished
	hurtbox.invincible = false


func hurt():
	Sound.play(Sound.hurt)
	Events.add_screenshake.emit(10, 0.1)
	PlayerStats.hurt(1)


func cool_down(delta: float):
	if cool_down_time > 0.0:
		cool_down_time -= delta


func fire_laser():
	if Input.is_action_pressed("fire") and is_weapon_cold():
		cool_down_time = LAZER_COOL_DOWN_TIME
		player_blaster.fire_bullet()


func fire_missile():
	if (Input.is_action_pressed("fire_missile")
	and is_weapon_cold()
	and PlayerStats.has_missiles()):
		cool_down_time = MISSILE_COOL_DOWN_TIME
		player_blaster.fire_missile()
		PlayerStats.fire_missile()


func is_weapon_cold() -> bool:
	return cool_down_time <= 0.0


func get_facing_direction() -> int:
	if Input.get_connected_joypads().is_empty():
		return sign(get_local_mouse_position().x)
	return sign(player_blaster.get_blaster_direction())
