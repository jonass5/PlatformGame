extends Stats

signal missiles_changed
signal max_missiles_changed

@export var max_missiles: int = 0 : set = set_max_missiles

@onready var missiles: int = max_missiles : set = set_missiles

func set_max_missiles(value: int):
	max_missiles = value
	max_missiles_changed.emit()


func set_missiles(value: int):
	missiles = clampi(value, 0, max_missiles)
	missiles_changed.emit()
