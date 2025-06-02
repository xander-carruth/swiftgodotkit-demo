extends Camera3D
signal yaw_changed(yaw: float)

@export var yaw_speed := 30.0 # °/s at full deflection
@export var pitch_speed := -30.0 # °/s
var _dir: Vector2 = Vector2.ZERO # last stick value
var _yaw_deg: float = 0.0
var _pitch_deg: float = 0.0 # clamped to ±60 °

# called by Main.gd whenever the knob moves
func set_stick(dir: Vector2) -> void:
	_dir = dir

func _process(delta: float) -> void:
	if _dir == Vector2.ZERO:
		return

	_yaw_deg -= _dir.x * yaw_speed * delta
	_pitch_deg = clamp(_pitch_deg + _dir.y * pitch_speed * delta, -60.0, 60.0)
	rotation_degrees = Vector3(_pitch_deg, _yaw_deg, 0.0)
	yaw_changed.emit(fposmod(_yaw_deg, 360.0))