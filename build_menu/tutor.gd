extends Node

static var disabled: bool = false

@onready var press_on_build: Panel = $PressOnBuild
@onready var press_on_empty_slot_in_deck: Panel = $PressOnEmptySlotInDeck
@onready var need_minumum_2_build_in_deck: Panel = $NeedMinumum2BuildInDeck
@onready var need_minumum_2_build_in_deck_button: Button = $NeedMinumum2BuildInDeck/NeedMinumum2BuildInDeckButton

func _ready() -> void:
	if disabled:
		return
	press_on_build.show()
	get_tree().get_nodes_in_group("build_card_in_storage").map(func(build_card): build_card.pressed.connect(_next_1, CONNECT_ONE_SHOT))

func disconnect_build_card_in_storage(build_card):
	if build_card.pressed.is_connected(_next_1):
		build_card.pressed.disconnect(_next_1)
	

func _next_1():
	get_tree().get_nodes_in_group("build_card_in_storage").map(disconnect_build_card_in_storage)
	press_on_build.hide()
	press_on_empty_slot_in_deck.show()
	
	get_tree().get_nodes_in_group("build_card_in_deck").map(func(build_card): build_card.pressed.connect(_next_2, CONNECT_ONE_SHOT))
	

func disconnect_build_card_in_deck(build_card):
	if build_card.pressed.is_connected(_next_2):
		build_card.pressed.disconnect(_next_2)

func _next_2():
	get_tree().get_nodes_in_group("build_card_in_deck").map(disconnect_build_card_in_deck)
	press_on_empty_slot_in_deck.hide()
	need_minumum_2_build_in_deck.show()
	await need_minumum_2_build_in_deck_button.pressed
	need_minumum_2_build_in_deck.hide()
	
	disabled = true
