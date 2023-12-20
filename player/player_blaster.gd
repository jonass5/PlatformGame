class_name PlayerBlaster
extends Node2D

const BulletScene = preload("res://player/bullet.tscn")
const MissleScene = preload("res://player/missile.tscn")

@onready var blaster_sprite = $BlasterSprite
@onready var muzzle = $BlasterSprite/Muzzle

func _process(_delta):
	blaster_sprite.rotation = get_local_mouse_position().angle()


func fire_bullet():
	var bullet = Utils.instanciate_scene_on_world(BulletScene, muzzle.global_position)
	bullet.rotation = blaster_sprite.rotation
	bullet.update_velocity()


func fire_missle():
	var missle = Utils.instanciate_scene_on_world(MissleScene, muzzle.global_position)
	missle.rotation = blaster_sprite.rotation
	missle.update_velocity()
