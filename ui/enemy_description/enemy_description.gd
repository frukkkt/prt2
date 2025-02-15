extends Control
@onready var enemy_name_label: Label = $Panel/EnemyNameLabel
@onready var enemy_description_label: Label = $Panel/EnemyDescriptionLabel
@onready var enemy_effect_description_label: Label = $Panel/EnemyEffectDescriptionLabel
@onready var hide_button: Button = $Panel/HideButton


func _on_hide_button_pressed() -> void:
	hide()

func _ready() -> void:
	Events.enemy_added.connect(_on_enemy_added)

func _on_enemy_added(enemy: Enemy):
	enemy.pressed.connect(_on_enemy_pressed.bind(enemy))
		
func _on_enemy_pressed(enemy: Enemy):
	var enemy_name: String = enemy.enemy_name
	var description: String = enemy.description
	var effects_descriptions: String = ""
	for i in enemy.effects:
		effects_descriptions += i.description
	create_enemy_description(enemy_name, description, effects_descriptions)

func create_enemy_description(_enemy_name: String, description: String, effects_descriptions: String):
	show()
	enemy_name_label.text = _enemy_name
	enemy_description_label.text = description
	enemy_effect_description_label.text = effects_descriptions
