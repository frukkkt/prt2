extends EnemySpawnEffect

@export var reducing_speed: float = 1

func effect(enemy: Enemy):
	enemy.speed -= reducing_speed
