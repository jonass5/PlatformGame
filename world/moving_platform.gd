class_name MovingPlatform
extends Node2D

@export var path : Curve2D

@onready var path_2d = $Path2D


func _ready():
	path_2d.curve = path

