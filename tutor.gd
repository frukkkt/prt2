extends Node

static var disabled: bool = false
@onready var base_build_tutor: Panel = $BaseBuildTutor

func _ready() -> void:
	if disabled:
		return
	base_build_tutor.show()
	await Events.base_build_added
	base_build_tutor.hide()
	disabled = true
