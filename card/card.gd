@tool
class_name Card
extends Button
@export var packed_build: PackedScene = null: set = set_packed_build 
@export var card_disabled: bool = false: set = set_card_disabled

func set_card_disabled(value):
	card_disabled = value
	disabled = value

func set_packed_build(value: PackedScene):
	packed_build = value
	set_name_build()

func _ready() -> void:
	if not Engine.is_editor_hint():
		set_name_build()

func set_name_build():
	if packed_build == null:
		text = ""
		return
	var build: Build = packed_build.instantiate()
	text = build.build_name


func _on_pressed() -> void:
	pass


func _on_button_up() -> void:
	if not Engine.is_editor_hint():
		Helper.create_audio(Helper.get_button_pressed_mp3())
