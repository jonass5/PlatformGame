class_name SaveStation
extends StaticBody2D

@onready var animation_player = $AnimationPlayer


func _on_area_2d_body_entered(_body):
	Sound.play(Sound.powerup, 0.6, -10.0)
	SaveManager.save_game()
	animation_player.play("save")
