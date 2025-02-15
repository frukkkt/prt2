extends Node2D

func _input(event: InputEvent) -> void:
	if event.is_action_released("attack"):
		create_attack()

func create_attack():
	const ATTACK = preload("uid://hpc32lpbxm68")
	add_child(ATTACK.instantiate())
