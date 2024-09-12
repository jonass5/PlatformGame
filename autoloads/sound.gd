extends Node

@export var bullet : AudioStream
@export var click : AudioStream
@export var enemy_die : AudioStream
@export var explosion : AudioStream
@export var hurt : AudioStream
@export var jump : AudioStream
@export var pause : AudioStream
@export var powerup : AudioStream
@export var step : AudioStream
@export var unpause : AudioStream

var sound_path = "res://music_and_sounds/"

@onready var sound_players = get_children()


func play(sound_stream: AudioStream, pitch_scale: float = 1.0, volume_db: float = 0.0):
	for sound_player: AudioStreamPlayer in sound_players:
		if not sound_player.playing:
			sound_player.pitch_scale = pitch_scale
			sound_player.volume_db = volume_db
			sound_player.stream = sound_stream
			sound_player.play()
			return
	print("Too many sounds playing at once")


func play_with_distance(sound_stream: AudioStream, position: Vector2, pitch_scale: float = 1.0):
	var distance = position.distance_to(MainInstances.player.global_position)
	var viewport_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	var volume_cluster = round(distance / viewport_width)
	if volume_cluster == 0:
		Sound.play(sound_stream, pitch_scale)
	elif volume_cluster == 1:
		Sound.play(sound_stream, pitch_scale, -5.0)
	elif volume_cluster == 2:
		Sound.play(sound_stream, pitch_scale, -10.0)
	elif volume_cluster == 3:
		Sound.play(sound_stream, pitch_scale, -20.0)
