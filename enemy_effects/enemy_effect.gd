class_name EnemyEffect
extends Node

@export var hide_effect_description: bool = false

@onready var description_label: Label = $DescriptionLabel
var description: String:
	get:
		if hide_effect_description:
			return ""
		return description_label.text
var enemy: Enemy = null

func effect(args: Array):
	pass
