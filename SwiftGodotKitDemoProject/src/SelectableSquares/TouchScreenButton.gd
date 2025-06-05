extends TouchScreenButton


@export var normal_color: Color = Color(0, 0, 0, 1) # black
@export var pressed_color: Color = Color(0.25, 0.25, 0.25) # lighter black

@onready var rect := $ColorRect # direct child ColorRect

func _ready() -> void:
	rect.color = normal_color
	pressed.connect(_on_pressed)
	released.connect(_on_released)

func _on_pressed() -> void: rect.color = pressed_color
func _on_released() -> void: rect.color = normal_color
