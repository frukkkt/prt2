class_name Goal
extends Node


signal finished
static var GOALS = load("res://ui/goal_reward/goals.tres")
@export var is_finished: bool = false:
	set(_value):
		is_finished = _value
		if is_finished:
			#print_debug(get_script().resource_path)
			GOALS.goal_finished[get_script().resource_path] = is_finished

@export var goal_value: float = 1
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var goal_label: Label = %GoalLabel
@export var goal_name: String = "Goal Name"

func _ready() -> void:
	load_is_finihed()

func load_is_finihed():
	await get_tree().process_frame
	is_finished = GOALS.goal_finished[get_script().resource_path]

func enable():
	goal_label.text = goal_name
	prepare()

func disable():
	pass

func prepare():
	pass

func reward_player():
	disable()
	is_finished = true
