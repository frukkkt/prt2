extends TouchScreenButton
@onready var build: Build = $".."


func _on_pressed() -> void:
	build.emit_signal("pressed")


func _on_released() -> void:
	pass # Replace with function body.
