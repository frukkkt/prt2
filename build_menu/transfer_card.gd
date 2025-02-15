extends Node

signal card_transferd

func _ready() -> void:
	connect_cards()

func connect_cards():
	for card in get_tree().get_nodes_in_group("card"):
		if card.pressed.is_connected(_on_card_pressed):
			continue
		card.pressed.connect(_on_card_pressed.bind(card))

var pressed_card: Card = null
func _on_card_pressed(card: Card):
	if card.packed_build == null and pressed_card == null:
		return
	if pressed_card == null:
		pressed_card = card
	else:
		if pressed_card == card:
			return
		var packed_scene = pressed_card.packed_build
		pressed_card.packed_build = card.packed_build
		card.packed_build = packed_scene
		
		pressed_card = null
		
		emit_signal("card_transferd")
	
	
