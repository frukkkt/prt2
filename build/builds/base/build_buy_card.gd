@tool
class_name BuildBuyCard
extends Card
@onready var cost_label: Label = $CostLabel
@onready var gold_texture: TextureRect = $GoldTexture
@onready var cristalls_texture: TextureRect = $CristallsTexture

var cost: int = 1: set = set_cost
var resource: Constants.CostResource = Constants.CostResource.GOLD: set = set_resource

func set_cost(value):
	if value == null:
		cost = 0
		cost_label.text = ""
	else:
		cost = value
		cost_label.text = str(cost)

func set_resource(value: Constants.CostResource):
	resource = value
	match resource:
		Constants.CostResource.GOLD:
			gold_texture.show()
			cristalls_texture.hide()
		Constants.CostResource.CRYSTALLS:
			gold_texture.hide()
			cristalls_texture.show()
		Constants.CostResource.NULL:
			gold_texture.hide()
			cristalls_texture.hide()
	

func _ready() -> void:
	if not Engine.is_editor_hint():
		super._ready()
		update_cost()
	
		set_process(false)
	
func update_cost():
	cost = Helper.get_cost_by_packed_build(packed_build)
	resource = Helper.get_cost_resource_by_packed_build(packed_build)



var is_action_cancelled : bool = false
func _on_button_down() -> void:
	is_action_cancelled  = false
	await get_tree().create_timer(0.4).timeout
	if is_action_cancelled  == true: return
	set_process(true)
	
func _on_button_up_2() -> void:
	is_action_cancelled  = true
	set_process(false)

var action_timer: float = 0.0
var action_interval: float = 0.1

func _process(delta: float) -> void:
	action_timer += delta
	if action_timer >= action_interval:
		action_timer = 0.0  # Сбрасываем таймер
		emit_signal("pressed")
