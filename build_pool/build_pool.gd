extends Node

var builds: Array[Build] = []
var moats: Array[Build] = []

func _ready() -> void:
	Events.build_added.connect(_on_build_added)

func _on_build_added(_build: Build):
	if _build.is_in_group("moat"):
		moats.append(_build)
	builds.append(_build)
