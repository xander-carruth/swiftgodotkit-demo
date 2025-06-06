extends MeshInstance3D

func _ready() -> void:
	var singleton = Engine.get_singleton("GodotSwiftMessenger")
	if singleton != null:
		singleton.change_cube_color.connect(_on_cube_color_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_x(delta)

func _on_cube_color_changed(times_changed: int) -> void:
	print("Color has been changed " + str(times_changed) + " times")
	var material = get_surface_override_material(0)
	material.albedo_color = Color(randf(), randf(), randf(), 1.0)
