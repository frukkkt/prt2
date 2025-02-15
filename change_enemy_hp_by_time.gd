extends Node

@export var hp_curve: Curve
@export var cycle_duration: int = 60  
var seconds: int = 0

func _on_timer_timeout() -> void:
	seconds += 1

func _ready() -> void:
	Events.enemy_added.connect(_on_enemy_added)

func _on_enemy_added(enemy: Enemy):
	var cycle_index: int = seconds / cycle_duration
	var cycle_position: int = seconds % cycle_duration
	var normalized_time: float = cycle_position / float(cycle_duration)
	
	var hp_multiplier: float = hp_curve.sample(normalized_time) * (cycle_index + 1)
	
	enemy.max_hp += seconds
	enemy.max_hp *= hp_multiplier
	enemy.hp = enemy.max_hp
