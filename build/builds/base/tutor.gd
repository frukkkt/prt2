extends Node

static var disabled: bool = false

@onready var fast_buy_on_1234: Panel = $FastBuyOn1234
@onready var fast_buy_button: Button = $FastBuyOn1234/FastBuyButton
@onready var fast_choose_on_qwer: Panel = $FastChooseOnQWER
@onready var fast_choose_button: Button = $FastChooseOnQWER/FastChooseButton

func _ready() -> void:
	if disabled:
		return
	fast_buy_on_1234.show()
	await fast_buy_button.pressed
	fast_buy_on_1234.hide()
	fast_choose_on_qwer.show()
	await fast_choose_button.pressed
	fast_choose_on_qwer.hide()
	disabled = true
	
