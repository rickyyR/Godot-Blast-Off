Things that are different to a Godot new project:

SETTINGS:
	Window:
		Resolution and Test Resolution set to 640x360
		Stretch set to Viewport keep Aspect
	
	Rendering - 2d:
		Enabled GPU Pixel Snap

	Debug:
		Force Fps set to 60
		
GENERAL:
	Audio:
		Added Effects and Music Audiobus

PREMADE SCENES:
	Main Menu with Buttons to change Scenes
	Options Menu with working options for Sound and Display
	Credits Screen with scrolling Credits (Exit with Keyboard Event)
	Empty Level

AUTOLOADS:
	Script for storing variables accessed by different Scenes (GlobalVariables)
	SceneFader to transition between Scenes
	MusicPlayer
	PauseMenu triggered with ESC Button inside a Level
	SavingSystem setup to save Sound and Display options
