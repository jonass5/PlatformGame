class_name TeleportEffect
extends Effect


func _ready():
	animation_looped.connect(queue_free)
