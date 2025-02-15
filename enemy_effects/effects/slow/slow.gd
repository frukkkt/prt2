extends EnemyEffect

@export var time: float = 1

func effect(args: Array): # start_slow_signal, end_slow_signal
	var start_signal: Signal = args[0]
	var end_signal: Signal = args[1]
	start_signal.connect(slow)
	end_signal.connect(unslow)

func slow():
	enemy.speed /= 2

func unslow(_enemy):
	enemy.speed *= 2
