# MusicPlayer
extends AudioStreamPlayer

# You can add more tracks to this list
onready var playlist:= [preload("res://Assets/menu_soundtrack_by_cactusdude.ogg")]
onready var current_track_index:= 0

func _ready() -> void:
	play_specific_from_playlist(current_track_index)
	switch_playing()

func play_random() -> void:
	randomize()
	var rand_index = randi() % playlist.size() - 1
	stream = playlist[rand_index]
	current_track_index = rand_index
	
func play_specific_from_playlist(index: int) -> void:
	if index > playlist.size() - 1:
		pass
	else:
		current_track_index = index
		stream = playlist[current_track_index]
	
func play_next() -> void:
	if current_track_index + 1 > playlist.size() - 1:
		current_track_index = 0
	else:
		current_track_index += 1
	stream = playlist[current_track_index]

func play_previous() -> void:
	if current_track_index - 1 < 0:
		current_track_index = playlist.size() - 1
	else:
		current_track_index -= 1
		
	stream = playlist[current_track_index]
	
func switch_playing() -> void:
	if playing:
		playing = false
	else:
		playing = true
