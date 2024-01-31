class_name Enemy
extends Node


func init(enemy):
	if WorldStash.is_freed(enemy):
		enemy.queue_free()
	enemy.enemy_health_bar.max_value = enemy.stats.max_health
	enemy.enemy_health_bar.value = enemy.stats.health


func no_health(enemy):
	WorldStash.freed(enemy)
	enemy.queue_free()


func hurt(enemy):
	enemy.enemy_health_bar.value = enemy.stats.health


