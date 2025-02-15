extends Control
@onready var gold_goal: Node = $GoldGoal
@onready var crystall_goal: Node = $CrystallGoal
@onready var boss_goal: Node = $BossGoal
@onready var build_base: Node = $BuildBase

@export var goal_order: Array[Goal]

func _ready() -> void:
	goal_order.insert(0, build_base)
	enable_goals_in_turn()

var index: int = 0
func enable_goals_in_turn():
	for goal in goal_order:
		if goal.is_finished:
			continue
		goal.enable()
		await goal.finished
		goal.disable()
	
