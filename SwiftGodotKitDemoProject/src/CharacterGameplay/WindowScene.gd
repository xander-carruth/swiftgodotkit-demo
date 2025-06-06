extends Node3D

# Unique token for scene, set in iOS app
@export var ready_token: String = ""

func _ready() -> void:
	await get_tree().process_frame
	var singleton = Engine.get_singleton("GodotSwiftMessenger")
	if singleton != null:
		singleton.scene_ready.emit(ready_token)