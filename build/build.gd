@tool
class_name Build
extends Node2D

signal pressed()

@onready var my_area_2d: MyArea2d = %MyArea

@export var max_hp := 1.0
@onready var hp := max_hp

@export var build_name: String = "Build Name"
@onready var _description_label: Label = $DescriptionLabel
var description: String = "Description":
	get:
		return _description_label.text
@export var effects: Array[BuildEffect]: get = get_effects
@export var start_effects: Array[PackedScene] = []

@export var update_button: bool = false: set = set_update_button

func set_update_button(value):
	update_button = false
	update()

func update():
	build_name = name

func _ready() -> void:
	if not Engine.is_editor_hint():
		
		for i in start_effects:
			if i == null:
				continue
			add_effect(i.instantiate())
		await get_tree().process_frame
		Helper.create_audio(Helper.get_build_created_mp3(), "Master", true)

func get_effects() -> Array[BuildEffect]:
	if Engine.is_editor_hint():
		return []
	var array: Array[BuildEffect] = []
	var pre_array = Helper.get_nodes_in_group_in_node(self, "build_effect")
	array.assign(pre_array)
	return array

func destroy():
	queue_free()
	Events.emit_signal("build_destroyed", self)
	Events.emit_signal("builds_changed")

func add_effect(effect: BuildEffect, only_one: bool = false):
	if only_one == true:
		for _effect in effects:
			if _effect.get_script() == effect.get_script():
				return
	effect.build = self
	add_child(effect)

func take_damage(damage: float, dealer):
	#Helper.create_audio(Helper.get_build_hit_mp3())
	hp -= damage
	if hp <= 0:
		destroy()
		Events.emit_signal("build_destroyed_by", dealer)

@onready var shine_effect: ColorRect = %ShineEffect
func shine():
	shine_effect.show()
	var shader_material: ShaderMaterial = shine_effect.material
	shader_material.set_shader_parameter("speed", 0.6)
	shader_material.set_shader_parameter("speed", 0.7)
	await get_tree().create_timer(1.0).timeout
	shine_effect.hide()
