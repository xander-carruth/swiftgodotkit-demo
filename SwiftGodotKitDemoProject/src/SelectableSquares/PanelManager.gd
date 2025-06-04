extends Node
signal color_chosen(colour: String)

@export var character: Node # drag the Camera3D

@onready var select_button := $"../Hud/SelectButton"

var _active: Node = null

func _ready():
	character.yaw_changed.connect(_on_orient)
	select_button.pressed.connect(_on_select)

func _on_orient(yaw: float) -> void:
	var is_set = false
	for p in get_tree().get_nodes_in_group("panels"):
		var inside := _within_window(yaw, p.angle_from, p.angle_to)
		p.set_active(inside)
		if inside:
			_active = p
			is_set = true
	if !is_set:
		_active = null
		

func _on_select() -> void:
	if _active:
		var color_name := _active.name.replace("Panel", "")
		print("Player chose: ", color_name)
		var singleton = Engine.get_singleton("GodotSwiftMessenger")
		if singleton != null:
			singleton.panel_selected.emit(color_name)

func _within_window(yaw: float, from: float, to: float) -> bool:
	if from <= to:
		return yaw >= from and yaw <= to
	else:
		return (yaw >= from) or (yaw <= to)
