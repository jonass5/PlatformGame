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


func reset():
	max_health = starting_max_health
	max_missiles = starting_max_missiles
	refill()


func refill():
	health = max_health
	missiles = max_missiles


func stash_stats():
	WorldStash.stash("player", "max_health", max_health)
	WorldStash.stash("player", "max_missiles", max_missiles)


func retrieve_stats():
	max_health = WorldStash.retrieve("player", "max_health")
	max_missiles = WorldStash.retrieve("player", "max_missiles")
	refill()
