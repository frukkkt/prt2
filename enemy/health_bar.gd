extends Node
@onready var health_bar: ProgressBar = %HealthBar
@onready var enemy: Enemy = $".."

static var is_alt_pressed: bool = true

func _ready() -> void:
	toggle_health_bar_visibility()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("alt"):
		is_alt_pressed = !is_alt_pressed
	toggle_health_bar_visibility()

func toggle_health_bar_visibility():
	health_bar.visible = is_alt_pressed

func _process(delta: float) -> void:
	health_bar.max_value = enemy.max_hp
	health_bar.value = enemy.hp
