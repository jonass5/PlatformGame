class_name LevelTitle
extends Node2D

@export var title: String

@onready var label = $Label
@onready var animation_player = $AnimationPlayer


func _ready():
	label.text = title
	animation_player.play("fade_in_and_out")
