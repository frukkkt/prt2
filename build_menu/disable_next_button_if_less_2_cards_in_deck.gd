extends Node
@onready var next_button: Button = %NextButton
@onready var transfer_card: Node = %TransferCard

func _ready() -> void:
	check()
	transfer_card.card_transferd.connect(check)

func check():
	var count = 0
	for i in get_tree().get_nodes_in_group("build_card_in_deck"):
		var card: BuildCardInDeck = i
		if card.packed_build != null:
			count += 1
	if count < 2:
		next_button.disabled = true
	else:
		next_button.disabled = false
			
