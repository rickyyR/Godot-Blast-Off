extends Node

const SAVE_DIR = "user://saves/"

var save_path = SAVE_DIR + "save.dat"

func save_data() -> void:
	# You can add things to save here. 
	#Note that the loading order must match the saving order
	var options_data = GlobalVariables.settings
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	var file = File.new()
	# Save without encryption
	var error = file.open(save_path, File.WRITE)
	# Save with encryption. Pass any String you want as last parameter
	#var error = file.open_encrypted_with_pass(save_path, File.WRITE, "YourKeyHere")
	if error == OK:
		file.store_var(options_data)
		file.close()

func load_data() -> void:
	var file = File.new()
	if file.file_exists(save_path):
		# Load without encryption
		var error = file.open(save_path, File.READ)
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
	dir.remove(save_path)
