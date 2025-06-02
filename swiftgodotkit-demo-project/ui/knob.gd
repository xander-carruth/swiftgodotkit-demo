extends Sprite2D

signal vector_changed(dir: Vector2)
@onready var parent = $".."

var pressing = false

var deadzone = 15
@export var maxLength = 150

func _ready():
	deadzone = parent.deadzone
	maxLength *= parent.scale.x

func _process(delta):
	if pressing:
		if get_global_mouse_position().distance_to(parent.global_position) <= maxLength:
			global_position = get_global_mouse_position()
		else:
			var angle = parent.global_position.angle_to_point(get_global_mouse_position())
			global_position.x = parent.global_position.x + cos(angle) * maxLength
			global_position.y = parent.global_position.y + sin(angle) * maxLength
		calculateVector()
	else:
		global_position = lerp(global_position, parent.global_position, delta * 50)
		emit_signal("vector_changed", Vector2.ZERO)
		
func calculateVector():
	var out := Vector2.ZERO
	if abs((global_position.x - parent.global_position.x)) >= deadzone:
		out.x = (global_position.x - parent.global_position.x) / maxLength
	if abs((global_position.y - parent.global_position.y)) >= deadzone:
		out.y = (global_position.y - parent.global_position.y) / maxLength
	emit_signal("vector_changed", out)

		
func _on_button_button_down():
	pressing = true


func _on_button_button_up():
	pressing = false
