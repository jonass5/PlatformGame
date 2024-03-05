class_name InputMapButton
extends HBoxContainer

@export var action_name : String = "ACTION NAME"

@onready var input_button = $InputButton
@onready var input_label = $InputLabel


func _ready():
	input_label.text = action_name
	
	var current_events = InputMap.action_get_events(action_name)
	
	if current_events.size() > 0:
		input_button.text = current_events[0].as_text()
	else:
		input_button.text = "NOT SET"
