extends MeshInstance3D

@export var angle_from := 0.0
@export var angle_to := 90.0

func set_active(on: bool) -> void:
   var material = get_surface_override_material(0)
   # Set material to glow
   if (on):
      material.emission_enabled = true
      material.emission_energy = 5.0
      material.emission = material.albedo_color
   else:
      material.emission_enabled = false