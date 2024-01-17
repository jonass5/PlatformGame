class_name PlayerBlaster
extends Node2D

const BulletScene = preload("res://player/bullet.tscn")
const MissileScene = preload("res://player/missile.tscn")

@onready var blaster_sprite = $BlasterSprite
@onready var muzzle = $BlasterSprite/Muzzle

func _process(_delta):
	if not Input.get_connected_joypads().is_empty():
		var joypad_face_rotation = Input.get_vector("face_left", "face_right", "face_up", "face_down")
		blaster_sprite.rotation = joypad_face_rotation.angle()
	else:
		blaster_sprite.rotation = get_local_mouse_position().angle()
	


func fire_bullet():
	var bullet = Utils.instanciate_scene_on_world(BulletScene, muzzle.global_position)
	bullet.rotation = blaster_sprite.rotation
	bullet.update_velocity()


func fire_missile():
	var missile = Utils.instanciate_scene_on_world(MissileScene, muzzle.global_position)
	missile.rotation = blaster_sprite.rotation
	missile.update_velocity()
