class_name BossEnemy
extends Node2D

const StingerScence = preload("res://enemies/stinger.tscn")

@export var acceleration: int = 200
@export var max_speed: int = 800
@export var targets: Array[NodePath]

var state = rush_state
var velocity: Vector2 = Vector2.ZERO

@onready var stats = $Stats
@onready var stinger_pivot = $StingerPivot
@onready var muzzle = $StingerPivot/Muzzle
@onready var firerate_timer = $FirerateTimer
@onready var state_timer = $StateTimer


func _process(delta: float):
	state.call(delta)


func rush_state(delta: float):
	var player = MainInstances.player
	if not player is PlayerChar: return
	var direction: Vector2 = global_position.direction_to(player.global_position)
	velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	move(delta)


func fire_state(_delta: float):
	if firerate_timer.time_left == 0:
		stinger_pivot.rotation_degrees += 17
		firerate_timer.start()
		var stinger = Utils.instanciate_scene_on_world(StingerScence, muzzle.global_position)
		stinger.rotation = stinger_pivot.rotation
		stinger.update_velocity()


func recenter_state(_delta: float):
	assert(not targets.is_empty())
	set_process(false)
	var center_node = get_node(targets.pick_random())
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "global_position", center_node.global_position, 2.0)
	await tween.finished
	set_process(true)
	state = rush_state


func decelertate_state(delta: float):
	velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
	move(delta)
	if velocity == Vector2.ZERO:
		state = recenter_state


func move(delta: float):
	translate(velocity * delta)


func _on_hurtbox_hurt(_hitbox, damage: int):
	stats.health -= damage


func _on_stats_no_health():
	queue_free()


func _on_state_timer_timeout():
	state = decelertate_state
