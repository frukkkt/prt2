class_name Enemy
extends Node2D

signal pressed()
signal died()

@onready var name_label: Label = $NameLabel
var enemy_name: String: 
	get:
		return name_label.text
@onready var description_label: Label = $DescriptionLabel
var description: String:
	get:
		return description_label.text

@onready var character_body_2d: CharacterBody2D = %CharacterBody2D

@export var speed: float = 11: set = set_speed, get = get_speed

@export var max_hp: int = 1
@onready var hp := max_hp

func take_damage(damage, dealer):
	Helper.create_audio(Helper.get_enemy_hit_mp3(), "Master", true)
	hp -= damage
	if hp <= 0:
		dead()
		Events.emit_signal("enemy_died_by", dealer)

func dead():
	queue_free()
	Events.emit_signal("enemy_died", self)
	Events.emit_signal("enemies_changed")
	emit_signal("died")
	
	Helper.create_audio(Helper.get_enemy_dead_mp3(), "SFX", true)


func set_speed(_value):
	if _value <= 0:
		speed = 1
	else:
		speed = _value

func get_speed():
	var value = speed
	if value > 11:
		return 11
	return value

@onready var enemy_effects: EnemyEffects = %EnemyEffects
func add_effect(effect: EnemyEffect):
	enemy_effects.add_effect(effect)

var effects: Array[EnemyEffect]:
	get:
		return enemy_effects.effects
