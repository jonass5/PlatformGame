class_name Instances
extends Node

var player: Player = null
var world: World = null
var level: Level = null

func stash_stats():
	WorldStash.stash("player", "x", player.global_position.x)
	WorldStash.stash("player", "y", player.global_position.y)
	WorldStash.stash("level", "file_path", level.scene_file_path)

func retrieve_stats():
	pass
