class_name JoyInput
extends Node

func _ready():
	for joypad in Input.get_connected_joypads():
		print("joypad: ", joypad)


func _process(delta):
	var joypad_face_rotation = Input.get_vector("face_left", "face_right", "face_up", "face_down")
	print("joypad_face_rotation: ", joypad_face_rotation)

	var joypad_move_rotation = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	print("joypad_move_rotation: ", joypad_move_rotation)
