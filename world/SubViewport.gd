extends SubViewport

@onready var level_01 = $"../../../Level01"
@onready var player = $"../../../Player"
@onready var camera_2d = $Camera2D

func _process(_delta):
	world_2d = level_01.get_viewport().world_2d
	
	camera_2d.position = player.camera_2d.position
	print(player.camera_2d.position)
