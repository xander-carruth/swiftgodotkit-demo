extends Node2D

@export var deadzone = 15
signal moved(dir: Vector2)

@onready var knob := get_node("Knob")
var posVector := Vector2.ZERO # optional pull API

func _ready() -> void:
    knob.vector_changed.connect(_on_knob_vector) # ← safe in Godot 4

func _on_knob_vector(v: Vector2) -> void:
    posVector = v
    emit_signal("moved", v) # push API