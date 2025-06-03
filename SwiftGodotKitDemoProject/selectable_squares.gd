extends Node3D

@onready var joystick := $"Hud/Joystick" # inside HUD instance
@onready var camera := $"Character/Camera3D"


func _ready() -> void:
	# do nothing
	print("ready")
