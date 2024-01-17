class_name JoyInput
extends Node

func _ready():
	for joypad in Input.get_connected_joypads():
		print("joypad: ", joypad)


func _process(_delta):
	var joypad_face_rotation = Input.get_vector("face_left", "face_right", "face_up", "face_down")
	#var joypad_face_rotation = Input.get_vector("move_left", "move_right", "jump", "crouch")
	if not joypad_face_rotation == Vector2.ZERO:
		print("joypad_face_rotation: ", joypad_face_rotation)
		print("angle: ", joypad_face_rotation.angle())


