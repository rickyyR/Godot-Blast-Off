# MusicPlayer
# Note that the play_... functions will only change the Players stream,
# if playing is set to false you will have to call switch_playing() after to start
extends AudioStreamPlayer

const modes:= ["PLAY_NEXT", "PLAY_PREVIOUS", "PLAY_RANDOM", "LOOP"]
# You can add more tracks to this list
var playlist:= [preload("res://Assets/menu_soundtrack_by_cactusdude.ogg")]
var current_mode = "PLAY_NEXT" setget set_mode, get_mode
# The current tracks index inside the playlist
# to prevent use of .find("Track") inside play-next/previous
var _current_track_index:= 0 setget set_current_index, get_current_index

func _ready() -> void:
	play_specific_from_playlist(_current_track_index)
	

func play_random() -> void:
	randomize()
	var rand_index = randi() % playlist.size() - 1
	stream = playlist[rand_index]
	_current_track_index = rand_index
	
func play_specific_from_playlist(index: int) -> void:
	if index > playlist.size() - 1:
		pass
	else:
		_current_track_index = index
		stream = playlist[_current_track_index]
	
func play_next() -> void:
	if _current_track_index + 1 > playlist.size() - 1:
		_current_track_index = 0
	else:
		_current_track_index += 1
	stream = playlist[_current_track_index]

func play_previous() -> void:
	if _current_track_index - 1 < 0:
		_current_track_index = playlist.size() - 1
	else:
		_current_track_index -= 1
		
	stream = playlist[_current_track_index]
	
func switch_playing() -> void:
	if playing:
		playing = false
	else:
		playing = true
		
func set_mode(new_mode: String) -> void:
	if modes.find(new_mode) != -1:
		current_mode = new_mode
		
func get_mode() -> String:
	return current_mode
	
func set_current_index(new_index: int) -> void:
	if new_index >= playlist.size() - 1:
		_current_track_index = new_index
		
func get_current_index() -> int:
	return _current_track_index
	
func _on_MusicPlayer_finished() -> void:
	match current_mode:
		"PLAY_NEXT":
			play_next()
		"PLAY_PREVIOUS":
			play_previous()
		"PLAY_RANDOM":
			play_random()
		"LOOP":
			play_specific_from_playlist(_current_track_index)
			
