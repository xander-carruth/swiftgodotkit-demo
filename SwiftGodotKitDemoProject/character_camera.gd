extends Camera3D
signal yaw_changed(yaw: float)

@export var yaw_speed := 30.0 # °/s at full deflection
@export var pitch_speed := -30.0 # °/s
var _dir: Vector2 = Vector2.ZERO # last stick value
var _yaw_deg: float = 0.0
var _pitch_deg: float = 0.0 # clamped to ±60 °

var _look_stick := Vector2.ZERO
@onready var _player := get_parent()

# called by Main.gd whenever the knob moves
func set_stick(id: String, dir: Vector2) -> void:
	if id == "CGRotation":
		_look_stick = dir

func _process(delta: float) -> void:
	if _look_stick == Vector2.ZERO:
		return

	 # ---- yaw: rotate the character body ----
	_player.rotate_y(deg_to_rad(-_look_stick.x * yaw_speed * delta))

	 # ---- pitch: rotate camera (X axis only) ----
	_pitch_deg = clamp(_pitch_deg + _look_stick.y * pitch_speed * delta, -60, 60)
	rotation_degrees = Vector3(_pitch_deg, 0, 0)

	yaw_changed.emit(fposmod(_player.rotation_degrees.y, 360.0))