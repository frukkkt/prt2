extends EnemyEffect

@export var gold_drop: int = 5

func effect(args: Array):
	#await get_tree().process_frame
	var enemy: Enemy = get_node(args[0])
	enemy.died.connect(_on_enemy_died)

func _on_enemy_died():
	Score.gold += gold_drop
