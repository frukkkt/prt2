extends Node

@onready var enemy: Enemy = $".."
@export var damage: float = 1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_parent().is_in_group("build"):
		var build: Build = body.get_parent()
		build.take_damage(damage, enemy)
