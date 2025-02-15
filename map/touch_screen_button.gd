extends TouchScreenButton

var action_timer: float = 0.0
var action_interval: float = 0.1  # Интервал в секундах


func _process(delta: float) -> void:
	if Helper.lmb_pressed and mouse_entered:
		emit_pressed()

func emit_pressed() -> void:
	emit_signal("pressed")

var mouse_entered
func _on_area_2d_mouse_entered() -> void:
	mouse_entered = true

func _on_area_2d_mouse_exited() -> void:
	mouse_entered = false
