extends Node
var AVAILABLE_CARD = preload("res://build_menu/available_card.tres")

func _ready() -> void:
	var build_cards = get_tree().get_nodes_in_group("build_card_in_storage")
	
	var index = 0
	for i in AVAILABLE_CARD.available_cards:
		var build_card: BuildCardInStorage = build_cards[index]
		build_card.packed_build = i
		build_card.card_disabled = false
		build_card.set_name_build()
		index += 1
