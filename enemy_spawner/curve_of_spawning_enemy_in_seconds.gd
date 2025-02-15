extends Node
@export var hp_curve: Curve
@export var cycle_duration: int = 60  
var seconds: int = 0
@onready var enemy_spawner: EnemySpawner = $".."
@onready var timer: Timer = $Timer

func _ready() -> void:
	Events.base_build_added.connect(_on_base_added)

func _on_base_added():
	timer.start()

func _on_timer_timeout() -> void:
	seconds += 1
	change_enemy_in_second()

func change_enemy_in_second():
	var cycle_index: int = seconds / cycle_duration
	var cycle_position: int = seconds % cycle_duration
	var normalized_time: float = cycle_position / float(cycle_duration)
	
	var enemy_in_second: float = hp_curve.sample(normalized_time) * (cycle_index + 1)
	
	enemy_spawner.enemy_in_second = enemy_in_second
