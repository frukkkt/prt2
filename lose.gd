extends Node
@onready var canvas_layer: CanvasLayer = $CanvasLayer
var is_lose: bool = false

func _ready() -> void:
	Events.connect("build_destroyed", _on_build_destroyed)

func _on_build_destroyed(build: Build):
	if build.is_in_group("base"):
		lose()

func lose():
	get_tree().paused = true
	canvas_layer.show()
	Helper.create_audio(Helper.get_lose_mp3(), "SFX")
	await get_tree().create_timer(1).timeout
	is_lose = true
const BUILD_MENU = preload("res://build_menu/build_menu.tscn")
func _input(event: InputEvent) -> void:
	if is_lose:
		if event is InputEventKey:
			if event.pressed:
				get_tree().paused = false
				get_tree().change_scene_to_packed(BUILD_MENU)
				
				#Events.emit_signal("level_reloaded")
