class_name InputMapButton
extends HBoxContainer

@export var action_name : String = "ACTION NAME"
@export var action_name_alias : String = ""

@onready var input_label = $InputLabel


func _ready():
	if not action_name_alias.is_empty():
		input_label.text = action_name_alias
	else:
		input_label.text = action_name
	
	var current_events = InputMap.action_get_events(action_name)
	for action_name in current_events:
		if action_name.get_class() == "InputEventKey" || action_name.get_class() == "InputEventMouseButton":
			#TODO: add action to add and remove input
			var button = Button.new()
			button.text = action_name.as_text().trim_suffix(" (Physical)")
			add_child(button)
