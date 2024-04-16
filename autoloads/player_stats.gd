extends Stats

signal missiles_changed
signal max_missiles_changed

@export var max_missiles: int = 0 : set = set_max_missiles

@onready var missiles: int = max_missiles : set = set_missiles
@onready var starting_max_health = max_health
@onready var starting_max_missiles = max_missiles


func set_max_missiles(value: int):
	max_missiles = value
	max_missiles_changed.emit()


func set_missiles(value: int):
	missiles = clampi(value, 0, max_missiles)
	missiles_changed.emit()


func reset() -> void:
	max_health = starting_max_health
	max_missiles = starting_max_missiles
	refill()


func refill() -> void:
	health = max_health


func stash_stats() -> void:
	WorldStash.stash("player", "max_health", max_health)
	WorldStash.stash("player", "max_missiles", max_missiles)
	WorldStash.stash("player", "missiles", missiles)


func retrieve_stats() -> void:
	max_health = WorldStash.retrieve("player", "max_health")
	max_missiles = WorldStash.retrieve("player", "max_missiles")
	missiles = WorldStash.retrieve("player", "missiles")
	refill()


func has_missiles() -> bool:
	return missiles > 0


func fire_missile() -> int:
	missiles -= 1
	return missiles


func is_missiles_activated() -> bool:
	return max_missiles > 0
