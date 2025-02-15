extends Control

func _ready() -> void:
	Events.build_added.connect(_on_build_added)

func _on_build_added(build: Build):
	build.pressed.connect(_on_build_pressed.bind(build))
		
func _on_build_pressed(build: Build):
	var build_name: String = build.build_name
	var description: String = build.description
	var effects_descriptions: String = ""
	for i in build.effects:
		effects_descriptions += i.description
	create_build_description(build_name, description, effects_descriptions)

@onready var panel: Panel = $Panel
@onready var build_name: Label = $Panel/BuildName
@onready var build_description: Label = $Panel/BuildDescription
@onready var hide_button: Button = $Panel/HideButton
@onready var build_effect_description_label: Label = $Panel/BuildEffectDescriptionLabel

func create_build_description(_build_name: String, description: String, effects_descriptions: String):
	show()
	build_name.text = _build_name
	build_description.text = description
	build_effect_description_label.text = effects_descriptions


func _on_hide_button_pressed() -> void:
	hide()
