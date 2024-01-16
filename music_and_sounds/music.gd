extends Node


@onready var audio_stream_player = $AudioStreamPlayer

@export var main_theme : AudioStream


func play(song : AudioStream, from_position = 0.0) -> void:
	audio_stream_player.stream = song
	audio_stream_player.play(from_position)


func fade(duration = 1.0) -> void:
	var previous_volume_db = audio_stream_player.volume_db
	var volume_fade = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	volume_fade.tween_property(audio_stream_player, "volume_db", -50.0, duration)
	await volume_fade.finished
	audio_stream_player.stop()
	audio_stream_player.volume_db = previous_volume_db
