extends Node

func _ready() -> void:
	var build_buy_cards: Array[BuildBuyCard] = Helper.get_build_buy_cards()
	for build_buy_card in build_buy_cards:
		if build_buy_card.pressed.is_connected(_on_button_pressed) == false:
			build_buy_card.pressed.connect(_on_button_pressed.bind(build_buy_card))

func _on_button_pressed(build_buy_card: BuildBuyCard):
	if build_buy_card.resource == Constants.CostResource.GOLD:
		if Score.gold >= build_buy_card.cost:
			Score.gold -= build_buy_card.cost
			add_build_card(build_buy_card)
	elif build_buy_card.resource == Constants.CostResource.CRYSTALLS:
		if Score.crystalls >= build_buy_card.cost:
			Score.crystalls -= build_buy_card.cost
			add_build_card(build_buy_card)

func add_build_card(build_buy_card: BuildBuyCard):
	var build_card = Helper.get_build_card_from_build_buy_card(build_buy_card)
	Helper.add_build_card(build_card)
	
