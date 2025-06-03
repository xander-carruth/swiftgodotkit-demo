# joystick.gd  – attach to the pad background
extends Node2D
@export var deadzone := 15
@export var max_length := 150.0
@export var action_left := "ui_left"
@export var action_right := "ui_right"
@export var action_up := "ui_up"
@export var action_down := "ui_down"

@onready var knob := $Knob
var _dir := Vector2.ZERO # last frame’s vector

func _ready():
    knob.vector_changed.connect(_on_vector)

func _on_vector(v: Vector2) -> void:
    # --- emit analog strengths into the Input system ---
    _publish_axis(action_left, -v.x) # negative X
    _publish_axis(action_right, v.x) # positive X
    _publish_axis(action_up, -v.y) # negative Y (up on screen)
    _publish_axis(action_down, v.y) # positive Y
    _dir = v

func _publish_axis(action: String, strength: float) -> void:
    strength = clamp(strength, 0.0, 1.0)
    if strength > 0.001:
        Input.action_press(action, strength)
    else:
        Input.action_release(action)
