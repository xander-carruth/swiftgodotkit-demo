extends MeshInstance3D
signal yaw_changed(yaw: float)
@onready var head = $Head

const SENSITIVITY = 0.10

func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		rotate_y(deg_to_rad(-event.relative.x * SENSITIVITY))
		head.rotate_x(deg_to_rad(-event.relative.y * SENSITIVITY))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-45), deg_to_rad(60))
		var yaw = fposmod(rotation_degrees.y, 360.0)
		yaw_changed.emit(yaw)
