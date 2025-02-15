extends Goal

@export var unlocked_build: PackedScene = null
@export var wait_time: float = 5.0

func stop_spawning_enemy():
	await Helper.stop_enemy_spawning(wait_time)

func spawn_boss():
	const BOSS_ENEMY = preload("uid://dsyxf7bfftyk6")
	var boss_enemy: Enemy = BOSS_ENEMY.instantiate()
	Helper.spawn_enemy(boss_enemy, 56)
	

func enable():
	super.enable()
	progress_bar.max_value = goal_value
	progress_bar.value = 0
	await stop_spawning_enemy()
	spawn_boss()

func disable():
	if Events.enemy_died.is_connected(_on_enemy_died):
		Events.enemy_died.disconnect(_on_enemy_died)

func prepare() -> void:
	Events.enemy_died.connect(_on_enemy_died)

func _on_enemy_died(enemy: Enemy):
	if enemy.is_in_group("boss"):
		progress_bar.value += 1
		#print_debug('boss_killed')
		reward_player()


func reward_player():
	super.reward_player()
	Helper.add_build_in_available(unlocked_build)
	var build_name : String = get_build_name()
	Helper.get_message_system().create_message_of_unlocking_new_build(build_name)
	emit_signal("finished")

func get_build_name():
	return unlocked_build.instantiate().build_name
