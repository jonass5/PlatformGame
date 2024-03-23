class_name InputMapButton
extends HBoxContainer

@export var action_key : String = "ACTION KEY"
@export var action_name : String = ""

@onready var input_label = $InputLabel


func _ready():
	set_label()
	create_buttons()


func set_label():
	if not action_name.is_empty():
		input_label.text = action_name
	else:
		input_label.text = action_key


func create_buttons():
	var current_events = InputMap.action_get_events(action_key)
	for action_event in current_events:
		if is_key_or_mouse_button_input_event(action_event):
			#TODO: add action to add and remove input
			create_button(action_event)


func create_button(action_event: InputEvent):
	var button = Button.new()
	button.text = action_event.as_text().trim_suffix(" (Physical)")
	add_child(button)


func is_key_or_mouse_button_input_event(action_event: InputEvent) -> bool:
	return action_event.get_class() == "InputEventKey" || action_event.get_class() == "InputEventMouseButton"

