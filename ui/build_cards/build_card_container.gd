class_name BuildCardContainer
extends Control
@onready var h_box_container: HBoxContainer = $HBoxContainer

func add_build_card(new_build_card: BuildCard) -> void:
	for child in h_box_container.get_children():
		if not child is BuildCard:
			continue
			
		var existing_card: BuildCard = child
		
		if existing_card.packed_build == new_build_card.packed_build:
			existing_card.count += 1
			Events.emit_signal("build_card_added", existing_card)
			Events.emit_signal("build_cards_changed")
			return
	
	h_box_container.add_child(new_build_card)
	Events.emit_signal("build_card_added", new_build_card)
	Events.emit_signal("build_cards_changed")

func delete_build_card(build_card: BuildCard):
	if build_card.count <= 1:
		build_card.queue_free()
		Events.emit_signal("build_card_deleted", build_card)
		Events.emit_signal("build_cards_changed")
	else:
		build_card.count -= 1
		Events.emit_signal("build_card_deleted", build_card)
		Events.emit_signal("build_cards_changed")
	
