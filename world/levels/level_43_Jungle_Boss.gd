extends Level

@onready var bricks = $Bricks
@onready var trigger = $Trigger
@onready var boss_enemy_path = $BossEnemy.get_path()


func _ready():
	bricks.hide()


func _on_trigger_trigger_entered():
	var boss_freed = WorldStash.retrieve(boss_enemy_path, "freed")
	if not boss_freed:
		bricks.show()
		trigger.active = false


func _on_boss_enemy_tree_exited():
	bricks.queue_free()
