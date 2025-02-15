extends CharacterBody2D

@export var speed = 250

func get_input():
	var input_direction = Input.get_vector("a", "d", "w", "s")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
