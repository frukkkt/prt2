class_name BuildCard
extends Card
@onready var count_label: Label = $CountLabel

var count = 1:
	set(value):
		count = value
		count_label.text = str(count)

func _ready() -> void:
	super._ready()
