class_name Missile
extends Projectile


func _ready():
	Sound.play(Sound.explosion)


func _on_hitbox_body_entered(body):
	super(body)
	if body.has_method("_on_missile_hit"):
		body._on_missile_hit()
