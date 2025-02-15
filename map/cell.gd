class_name Cell
extends Node2D

signal pressed

var build: Build = null

var neighbours: Array[Cell] = []

func _ready() -> void:
	await get_tree().process_frame
	neighbours = Helper.get_cell_neighbours(self)

func create_build(_build: Build, replace: bool = false):
	if build == null:
		return _add_build(_build)
	elif build != null and replace == true:
		build.queue_free()
		build = null
		return _add_build(_build)
	else:
		return false

func _add_build(_build): # private
	call_deferred("add_child", _build)
	build = _build
	Events.emit_signal("build_added", build)
	Events.emit_signal("builds_changed")
	return true

func _on_touch_screen_button_pressed() -> void:
	emit_signal("pressed")
