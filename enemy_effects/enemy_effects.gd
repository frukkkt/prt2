class_name EnemyEffects
extends Node
@onready var enemy: Enemy = $".."

var effects: Array[EnemyEffect] = []:
	get:
		var array: Array[EnemyEffect] = []
		array.assign(get_children())
		return array
@export var start_effect: Array[PackedScene]

func add_effect(effect: EnemyEffect):
	effect.enemy = enemy
	add_child(effect)

func _ready() -> void:
	if start_effect == []:
		return
	else:
		for i in start_effect:
			if i == null:
				continue
			var packed_effect: PackedScene = i
			add_effect(packed_effect.instantiate())
