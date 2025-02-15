extends Node

signal gold_changed
signal crystalls_changed

var ready_gold: int = 10
var ready_crystalls: int = 10

var gold: int = 10: set = set_gold
var crystalls: int = 10: set = set_crystalls

func set_gold(value):
	gold = value
	emit_signal("gold_changed")

func set_crystalls(value):
	crystalls = value
	emit_signal("crystalls_changed")

func _ready() -> void:
	Events.main_scene_ready.connect(_main_scene_ready)

func _main_scene_ready():
	gold = ready_gold
	crystalls = ready_crystalls
