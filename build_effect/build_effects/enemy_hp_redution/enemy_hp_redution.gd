extends BuildEffect

func effect():
	hp_down_enemies()
func hp_down_enemies():
	var enemy_spawner: EnemySpawner = Helper.get_enemy_spawner()
	var HP_DOWN_ON_SPAWN = load("res://enemy_spawn_effect/enemy_spawn_effects/hp_down_on_spawn/hp_down_on_spawn.tscn")
	enemy_spawner.add_enemy_spawn_effect(HP_DOWN_ON_SPAWN.instantiate())
