extends Node
var AVAILABLE_CARD = preload("res://build_menu/available_card.tres")
func _exit_tree() -> void:
	var build_cards = get_tree().get_nodes_in_group("build_card_in_storage")
	
	var available_cards: Array[PackedScene]
	for i in build_cards:
		var build_card: BuildCardInStorage = i
		if build_card.packed_build != null and build_card.card_disabled == false:
			available_cards.append(build_card.packed_build)
	AVAILABLE_CARD.available_cards = available_cards
	pass
