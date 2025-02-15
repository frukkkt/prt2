extends TouchScreenButton
@onready var enemy: Enemy = $"../.."


func _on_pressed() -> void:
	enemy.emit_signal("pressed")
