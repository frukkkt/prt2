extends BuildEffect

# это замедляет врагов когда они назодятся на горах

func get_enemy_entered() -> Signal:
	return build.my_area_2d.enemy_entered

func get_enemy_exited() -> Signal:
	return build.my_area_2d.enemy_exited

func _ready() -> void:
	effect()

func effect():
	get_enemy_entered().connect(_on_enemy_entered)

func _on_enemy_entered(enemy: Enemy):
	var enemy_slow_effect: EnemyEffect = preload("res://enemy_effects/effects/slow/slow.tscn").instantiate()
	enemy_slow_effect.enemy = enemy
	enemy_slow_effect.effect(
		[
			enemy_slow_effect.ready,
			get_enemy_exited()
		]
	)
	enemy.add_effect(enemy_slow_effect)
