extends Camera2D

var shake = 0

@onready var timer = $Timer

func _ready():
	Events.add_screenshake.connect(start_screenshake)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset.x = randf_range(-shake, shake)
	offset.y = randf_range(-shake, shake)
	
func start_screenshake(amount, duration):
	shake = amount
	timer.start(duration)

func _on_timer_timeout():
	shake = 0
