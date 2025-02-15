extends Node
var DECK = load("res://build_menu/deck.tres")

func _ready() -> void:
	await get_tree().process_frame
	var build_buy_cards: Array[BuildBuyCard] = Helper.get_build_buy_cards()
	var packed_builds: Array[PackedScene] = DECK.packed_builds
	var index = 0
	for i in build_buy_cards:
		if packed_builds.size() == index:
			return
		i.packed_build = packed_builds[index]
		i.update_cost()
		index += 1
