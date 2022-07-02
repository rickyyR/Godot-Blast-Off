extends Node

const _SAVE_DIR = "user://saves/"
const _file_name = "save.dat" 
const _save_path = _SAVE_DIR + _file_name 

func _ready() -> void:
	load_data()
	apply_user_settings()

func save_data() -> void:
	# You can add things to save here. 
	#Note that the loading order must match the saving order
	var options_data = GlobalVariables.settings
	var dir = Directory.new()
	if !dir.dir_exists(_SAVE_DIR):
		dir.make_dir_recursive(_SAVE_DIR)
	var file = File.new()
	# Save without encryption
	var error = file.open(_save_path, File.WRITE)
	# Save with encryption. Pass any String you want as last parameter
	#var error = file.open_encrypted_with_pass(save_path, File.WRITE, "YourKeyHere")
	if error == OK:
		file.store_var(options_data)
		file.close()

func load_data() -> void:
	var file = File.new()
	if file.file_exists(_save_path):
		# Load without encryption
		var error = file.open(_save_path, File.READ)
		# Load with encryption. 
		# Last parameter has to match the String passed as parameter in "Save with encryption"
		#var error = file.open_encrypted_with_pass(save_path, File.READ, "YourKeyHere")
		if error == OK:
			# You can add things to load here.
			# Note that the loading order must match the saving order
			var options_data = file.get_var()
			file.close()
			GlobalVariables.settings = options_data

func delete_all_data() -> void:
	var dir = Directory.new()
	dir.remove(_save_path)
	
func apply_user_settings() -> void:
	if not GlobalVariables.settings["Fullscreen"]:
		OS.set_window_size(GlobalVariables.settings["Resolution"])
		if GlobalVariables.settings["Borderless"]:
			OS.window_borderless = true
	else:
		OS.window_fullscreen = true
		
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),
	 linear2db(GlobalVariables.settings["MasterVolumePercent"]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"),
	 linear2db(GlobalVariables.settings["EffectsVolumePercent"]))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),
	 linear2db(GlobalVariables.settings["MusicVolumePercent"]))
	
	OS.center_window()
	
