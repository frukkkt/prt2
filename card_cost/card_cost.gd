@tool
extends Resource
const BUILDS = preload("res://build/builds.tres")

func _init() -> void:
	update_card_costs()

func update_card_costs():
	var all_builds: Dictionary = BUILDS.scene_dict
	if all_builds.size() == card_cost.size():
		return
	elif card_cost.size() < all_builds.size():
		BUILDS.set_update(true)
		for i in all_builds.values():
			if card_cost.has(i):
				continue
			else:
				card_cost[i] = get_default_cost()
		
@export var card_cost: Dictionary = {}
@export var update: bool = false: set = set_update

func set_update(value):
	update = false
	update_card_costs()

func get_default_cost():
	return load("res://card_cost/default_cost.tres")
