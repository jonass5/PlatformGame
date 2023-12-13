class_name PlayerBlaster
extends Node2D

const BulletScene = preload("res://player/bullet.tscn")

@onready var blaster_sprite = $BlasterSprite
@onready var muzzle = $BlasterSprite/Muzzle

func _process(_delta):
	blaster_sprite.rotation = get_local_mouse_position().angle()
	
func fire_bullet():
	var bullet = Utils.instanciate_scene_on_world(BulletScene, muzzle.global_position)
	bullet.rotation = blaster_sprite.rotation
	bullet.update_velocity()
