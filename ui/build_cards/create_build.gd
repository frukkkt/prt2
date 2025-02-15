extends Node

var pressed_build_card: BuildCard = null

func _ready() -> void:
	connect_build_cards()
	Events.build_cards_changed.connect(connect_build_cards)

func connect_build_cards():
	var build_cards: Array[BuildCard] = Helper.get_build_cards()
	for build_card in build_cards:
		if build_card.toggled.is_connected(_on_toggled) == true:
			continue
		build_card.toggled.connect(_on_toggled.bind(build_card))

func _on_toggled(_bool: bool, build_card: BuildCard):
	if _bool == true:
		toggle_off_other_build_cards(build_card)
		build_card.button_pressed = true
		pressed_build_card = build_card
		connect_on_cell_pressed()
	elif _bool == false:
		disconnect_on_cell_pressed()

func toggle_off_other_build_cards(_build_card: BuildCard):
	var build_cards: Array[BuildCard] = Helper.get_build_cards()
	for build_card in build_cards:
		if build_card == _build_card:
			continue
		build_card.button_pressed = false

func connect_on_cell_pressed():
	var cells: Array[Cell] = Helper.get_cells()
	for cell in cells:
		if cell == null:
			continue
		if cell.pressed.is_connected(_on_cell_pressed) == false:
			cell.pressed.connect(_on_cell_pressed.bind(cell))

func disconnect_on_cell_pressed():
	var cells: Array[Cell] = Helper.get_cells()
	for cell in cells:
		if cell == null:
			continue
		if cell.pressed.is_connected(_on_cell_pressed) == true:
			cell.pressed.disconnect(_on_cell_pressed)

func _on_cell_pressed(cell: Cell):
	if pressed_build_card == null:
		return
	var build: Node = pressed_build_card.packed_build.instantiate()
	if cell.create_build(build) == true:
		delete_presssed_build_card()
		#disconnect_on_cell_pressed()

@onready var build_cards: BuildCardContainer = %BuildCardContainer
func delete_presssed_build_card():
	build_cards.delete_build_card(pressed_build_card)
	#pressed_build_card = null
