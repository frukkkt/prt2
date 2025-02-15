extends Node

func _ready() -> void:
	Events.emit_signal("main_scene_ready")
