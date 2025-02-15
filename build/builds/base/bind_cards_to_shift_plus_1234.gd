extends Node

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("1"):
		button_down_build_card_by_event(1)
	if event.is_action_released("1"):
		button_up_build_card_by_event(1)
	if event.is_action_pressed("2"):
		button_down_build_card_by_event(2)
	if event.is_action_released("2"):
		button_up_build_card_by_event(2)
	if event.is_action_pressed("3"):
		button_down_build_card_by_event(3)
	if event.is_action_released("3"):
		button_up_build_card_by_event(3)
	if event.is_action_pressed("4"):
		button_down_build_card_by_event(4)
	if event.is_action_released("4"):
		button_up_build_card_by_event(4)

func button_down_build_card_by_event(event: int):
	var build_buy_card  = get_build_card_by_event(event)
	build_buy_card.emit_signal("button_down")
	build_buy_card.emit_signal("pressed")

func button_up_build_card_by_event(event: int):
	var build_buy_card  = get_build_card_by_event(event)
	build_buy_card.emit_signal("button_up")

func get_build_card_by_event(event: int):
	var build_buy_cards: Array[BuildBuyCard] = Helper.get_build_buy_cards()
	if build_buy_cards == []: return
	if build_buy_cards.size() < event: return
	var build_buy_card: BuildBuyCard = build_buy_cards[event - 1]
	return build_buy_card
