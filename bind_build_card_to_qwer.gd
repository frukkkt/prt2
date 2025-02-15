extends Node

func _input(event: InputEvent) -> void:
	if event is InputEventWithModifiers:
		if event.shift_pressed:
			return
	if event.is_action_pressed("q"):
		press_build_card_by_event(1)
	if event.is_action_pressed("w"):
		press_build_card_by_event(2)
	if event.is_action_pressed("e"):
		press_build_card_by_event(3)
	if event.is_action_pressed("r"):
		press_build_card_by_event(4)

func press_build_card_by_event(event: int):
	var build_cards: Array[BuildCard] = Helper.get_build_cards()
	if build_cards == []: return
	if build_cards.size() < event: return
	var build_card: BuildCard = build_cards[event - 1]
	build_card.button_pressed = !build_card.button_pressed
	build_card.emit_signal("pressed")
	
