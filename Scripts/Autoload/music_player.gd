# MusicPlayer
extends AudioStreamPlayer

var playlist:= ["Path1", "Path2"]

func play_random() -> void:
	pass
	
func play_specific_file(audio_path: String) -> void:
	pass
	
func play_specific_from_playlist(index: int) -> void:
	pass
	
func play_next() -> void:
	pass

func play_previous() -> void:
	pass
	
func switch_playing() -> void:
	if playing:
		playing = false
	else:
		playing = true
