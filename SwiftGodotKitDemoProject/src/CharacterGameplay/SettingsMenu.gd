extends Control

@onready var navigate_back_button = $"NavigateBackButton"
@onready var close_button = $"CloseMenuButton"

func _ready() -> void:
	navigate_back_button.pressed.connect(_on_navigate_back_pressed)
	close_button.pressed.connect(_on_close_pressed)


func _on_navigate_back_pressed() -> void:
	print("Navigating back")
	# Will log debug error when running Godot project outside of iOS app, this is to be expected
	var singleton = Engine.get_singleton("GodotSwiftMessenger")
	if singleton != null:
		singleton.game_ended.emit()

func _on_close_pressed() -> void:
	get_parent().close_menu()
