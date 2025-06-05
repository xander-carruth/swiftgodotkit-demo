extends CanvasLayer

@onready var settings_menu: Control = $"SettingsMenu"
@onready var settings_button: TouchScreenButton = $"SettingsButton"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	settings_menu.hide()
	settings_button.pressed.connect(_on_settings_pressed)

func close_menu() -> void:
	settings_menu.hide()

func _on_settings_pressed() -> void:
	settings_menu.show()
