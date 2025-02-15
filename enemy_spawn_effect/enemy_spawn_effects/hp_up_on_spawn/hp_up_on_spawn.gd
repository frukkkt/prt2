extends EnemySpawnEffect

@export var additional_hp: float = 5

func effect(enemy: Enemy):
	enemy.max_hp += additional_hp
	enemy.hp = enemy.max_hp
