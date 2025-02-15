extends EnemySpawnEffect

var reduicing_hp = 5

func effect(enemy: Enemy):
	enemy.max_hp -= reduicing_hp
	enemy.hp = enemy.max_hp
