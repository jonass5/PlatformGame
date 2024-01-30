class_name BossEnemy
extends Node2D

const StingerScence = preload("res://enemies/stinger.tscn")
const MissilePowerupScene = preload("res://player/missile_powerup.tscn")
const EnemyDeathEffectScene = preload("res://effects/enemy_death_effect.tscn")

@export var acceleration: int = 200
@export var max_speed: int = 800
@export var targets: Array[NodePath]

var state = recenter_state : set = set_state
var state_init = true : get = get_state_init
var velocity: Vector2 = Vector2.ZERO

var STATE_OPTIONS = [fire_state, fire_state, rush_state, rush_state]
var state_options_left = []

@onready var stats = $Stats
@onready var stinger_pivot = $StingerPivot
@onready var muzzle = $StingerPivot/Muzzle
@onready var firerate_timer = $FirerateTimer
@onready var state_timer = $StateTimer
@onready var enemy_health_bar = $EnemyHealthBar
@onready var enemy = $Enemy


func _ready():
	enemy_health_bar.max_value = stats.max_health
	enemy_health_bar.value = stats.health


func set_state(value):
	state = value
	state_init = true


func get_state_init():
	var was = state_init
	state_init = false
	return was


func _process(delta: float):
	state.call(delta)


func rush_state(delta: float):
	if state_init:
		state_timer.start(randf_range(4.0, 6.0))
		state_timer.timeout.connect(set_state.bind(decelertate_state), CONNECT_ONE_SHOT)
		state_init = false
	var player = MainInstances.player
	if not player is PlayerChar: return
	var direction: Vector2 = global_position.direction_to(player.global_position)
	velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	move(delta)


func fire_state(_delta: float):
	if state_init:
		state_timer.start(randf_range(4.0, 6.0))
		state_timer.timeout.connect(set_state.bind(recenter_state), CONNECT_ONE_SHOT)
	if firerate_timer.time_left == 0:
		stinger_pivot.rotation_degrees += 17
		firerate_timer.start()
		var stinger = Utils.instanciate_scene_on_world(StingerScence, muzzle.global_position)
		stinger.rotation = stinger_pivot.rotation
		stinger.update_velocity()


func recenter_state(_delta: float):
	assert(not targets.is_empty())
	if state_init:
		var center_node = get_node(targets.pick_random())
		var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "global_position", center_node.global_position, 2.0)
		await tween.finished
		state_timer.start(0.5)
		await state_timer.timeout
		if state_options_left.is_empty():
			state_options_left = STATE_OPTIONS.duplicate()
			state_options_left.shuffle()
		state = state_options_left.pop_back()


func decelertate_state(delta: float):
	velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
	move(delta)
	if velocity == Vector2.ZERO:
		state = recenter_state


func move(delta: float):
	translate(velocity * delta)


func _on_hurtbox_hurt(_hitbox, damage: int):
	stats.health -= damage
	enemy_health_bar.value = stats.health


func _on_stats_no_health():
	enemy.killed()
	Utils.instanciate_scene_on_world(MissilePowerupScene, global_position)
	for i in 6:
		var offset = Vector2(randf_range(-16, 16), randf_range(-16, 16))
		Utils.instanciate_scene_on_world(EnemyDeathEffectScene, global_position + offset)
