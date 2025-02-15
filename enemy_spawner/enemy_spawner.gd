@tool
class_name EnemySpawner
extends Node

@onready var markers: Node2D = $Markers
var reducing_enemy_is_seconds: float = 0
var enemy_in_second: float = 1: set = set_enemy_in_second, get = get_enemy_in_seconds
@onready var timer: Timer = $Timer

@export var enemy_and_weight: Dictionary = {}
@export_category("add_new_enemy")
@export var new_enemy_and_percent: Array = []# энеми и процент
@export var add_new_enemy:  bool = false: set = set_add_new_enemy
@export var enemy_spawn_effects: Array[EnemySpawnEffect] = []

func set_add_new_enemy(_value:bool):
	add_new_enemy = _value
	if new_enemy_and_percent == []:
		print_debug("хули new_enemy_and_percent равно []")
	elif new_enemy_and_percent.size() == 1:
		print_debug("хули new_enemy_and_percent.size равно 1")
	elif new_enemy_and_percent.size() > 2:
		print_debug("хули new_enemy_and_percent.size больше 1")
	elif new_enemy_and_percent[1] > 1.0 or new_enemy_and_percent[1] <= 0:
		print_debug("хули percent не 0 - 0.1")
	elif enemy_and_weight.has(new_enemy_and_percent[0]):
		print_debug("ТАКОЙ ЭНЕМИ УЖЕ ЕСТЬ")
	else:
		add_new_enemy = false
		var enemy: PackedScene = new_enemy_and_percent[0]
		var percent: float  = new_enemy_and_percent[1]
		add_enemy_by_percent(enemy, percent)
		new_enemy_and_percent = []
		print_debug("обнови enemy_and_weight")

func add_enemy_by_percent(enemy: PackedScene, percent: float):
	if enemy_and_weight.has(enemy):
		var total_weight = _get_total_weight()
		
		# Если раздокументировать то будет тяжелее набирать проценты спавна
		# кароче как в доте % вампиризма, только оно уже есть, это усилит это дерьмо
		#var enemy_weight = enemy_and_weight[enemy]
		#total_weight -= enemy_weight 
		
		var weight = percent * total_weight
		enemy_and_weight[enemy] += weight
	elif percent > 1.0 or percent <= 0:
		print_debug("percent  не 0 - 0.1")
	else:
		var total_weight = _get_total_weight()
		var weight = percent * total_weight
		enemy_and_weight[enemy] = weight

func _get_total_weight():
	var total_weight = 0
	for weight in enemy_and_weight.values():
		total_weight += weight 
	return total_weight

func delete_enemy_by_percent(enemy: PackedScene, percent: float):
	enemy_and_weight[enemy] -= percent
	if enemy_and_weight[enemy] <= 0:
		enemy_and_weight.erase(enemy)
	

func set_enemy_in_second(value: float):
	enemy_in_second = value
	timer.wait_time = 1.0 / enemy_in_second

func get_enemy_in_seconds():
	var value = enemy_in_second - reducing_enemy_is_seconds
	if value < 0.1:
		value = 0.1
	return value

func _ready() -> void:
	if not Engine.is_editor_hint():
		Events.base_build_added.connect(_on_base_build_added)

func _on_base_build_added():
	if timer.timeout.is_connected(_on_timer_timeout) == false:
		timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	create_random_enemy()

func create_random_enemy():
	var enemy: Enemy = get_random_enemy()
	create_enemy(enemy)

func get_random_enemy() -> Enemy:
	randomize()
	var total_weight = _get_total_weight()
	
	var random_value = randf_range(0, total_weight)
	
	var cumulative_weight = 0
	for packed_enemy in enemy_and_weight.keys():
		var weight = enemy_and_weight[packed_enemy]
		cumulative_weight += weight
		if random_value < cumulative_weight:
			var enemy: Enemy = packed_enemy.instantiate()
			return enemy
	return null
	

func get_random_marker():
	return markers.get_children().pick_random()

func get_marker_by_pos(pos):
	return markers.get_children()[pos]

func create_enemy(enemy: Enemy, pos: int = -1):
	var marker
	if pos == -1:
		marker = get_random_marker()
	else:
		marker = get_marker_by_pos(pos)
	marker.add_child(enemy)
	effect_on_enemy(enemy)
	Events.emit_signal("enemy_added", enemy)
	Events.emit_signal("enemies_changed")

func effect_on_enemy(enemy: Enemy):
	if enemy_spawn_effects == []:
		return
	else:
		for i in enemy_spawn_effects:
			i.effect(enemy)

func stop_spawning():
	timer.stop()

func start_spawning():
	timer.start()

func add_enemy_spawn_effect(enemy_spawn_effect: EnemySpawnEffect):
	enemy_spawn_effects.append(enemy_spawn_effect)
