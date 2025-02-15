extends Build

func _ready() -> void:
	super._ready()
	Events.emit_signal("base_build_added")
