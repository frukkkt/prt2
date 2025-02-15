extends Enemy

@export var gold_drop = 5

func dead():
	super.dead()
	Score.gold += gold_drop
