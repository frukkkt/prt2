@tool
extends Node

@export var curve: Curve
@onready var timer: Timer = $Timer

var seconds: int = 0

var cicle_up_border: int = 60

func _ready() -> void:
	timer.start()

func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	seconds += 1
	var koof = seconds / cicle_up_border 
	var seconds_in_curve = seconds - koof * cicle_up_border + 1
	print("seconds in curve: ", seconds - koof * cicle_up_border)
	print(seconds)
	var normalized_seconds_in_curve = float(seconds_in_curve) / float(cicle_up_border)
	var curve_y_value = curve.sample(normalized_seconds_in_curve)
	print(curve_y_value)
	
	print("after multiply on koof: ", curve_y_value * (koof + 1))
