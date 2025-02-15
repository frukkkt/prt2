extends Node
func _ready() -> void:
	var cards = get_tree().get_nodes_in_group("build_card_in_deck")
	var DECK = preload("uid://dnsitnqlbcp63")
	var index: int = 0
	for i in DECK.packed_builds:
		var packed_build: PackedScene = i
		var card: Card = cards[index]
		card.packed_build = packed_build
		index += 1
