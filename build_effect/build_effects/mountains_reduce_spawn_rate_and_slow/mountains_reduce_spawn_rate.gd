extends BuildEffect

# это замедляет спавнящизся врагов

@export var spawn_rate_reduction: float = 0.04

func _ready() -> void:
	effect()

func effect():
	slow_enemies()
	spawn_rate_down()
	build.tree_exited.connect(speed_up_enemies)
	build.tree_exited.connect(hp_down_enemies)

func slow_enemies():
	var enemy_spawner: EnemySpawner = Helper.get_enemy_spawner()
	var SLOW_DOWN_ON_SPAWN: PackedScene = load("uid://bxg2kwg0lwynj")
	enemy_spawner.add_enemy_spawn_effect(SLOW_DOWN_ON_SPAWN.instantiate())

func spawn_rate_down():
	var enemy_spawner: EnemySpawner = Helper.get_enemy_spawner()
	enemy_spawner.reducing_enemy_is_seconds += spawn_rate_reduction
	

func speed_up_enemies():
	pass

func hp_down_enemies():
	pass
