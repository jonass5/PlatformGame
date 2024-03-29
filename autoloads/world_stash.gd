class_name Stash
extends Node

var data = {}


func stash(id: String, key: String, value) -> void:
	if not data.has(id):
		data[id] = {}
	data[id][key] = value


func retrieve(id: String, key: String):
	if not data.has(id):
		return
	if not data[id].has(key):
		return
	return data[id][key]


func freed(node: Node) -> void:
	stash(node.get_path(), "freed", true)


func is_freed(node: Node) -> bool:
	return retrieve(node.get_path(), "freed") == true
