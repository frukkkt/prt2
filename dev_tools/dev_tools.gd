extends Node

@export var disabled: bool = false

func _input(event: InputEvent) -> void:
	if disabled:
		return
	if event.is_action_pressed("activate_dev_tools"):
		get_children().map(func(x): x.visible = !x.visible)
