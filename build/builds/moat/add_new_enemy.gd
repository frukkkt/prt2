extends Node
# Interaction всмысле эффект на что то

static var moats_number: int = 0
@export var value_for_add_flood: int = 10

var moats_in_scene: get = get_moats

func get_moats():
	return BuildPool.moats

func _ready() -> void:
	moats_number += 1
	#increase_enemy_change()
	interaction()

func _exit_tree() -> void:
	moats_number -= 1

func increase_enemy_change():
	var enemy_spawner: EnemySpawner = Helper.get_enemy_spawner()
	enemy_spawner.add_enemy_by_percent(load("uid://c7elr1alo7wun"), 0.05)

func descrease_enemy_change() -> void:
	var enemy_spawner: EnemySpawner = Helper.get_enemy_spawner()
	enemy_spawner.delete_enemy_by_percent(load("uid://c7elr1alo7wun"), 0.05)

func interaction():
	#await get_tree().process_frame # чтобы moat успел заспавнится, иначе на его позиции может
	# заспаавнится flood(если moat впритык с другим moat)
	if moats_number < value_for_add_flood:
		delete_flood()
	elif moats_number >= value_for_add_flood:
		add_flood()

func delete_flood():
	# тоже проверить - есть ли
	pass

func add_flood():
	for i in get_moats():
		if i == null:
			continue
		var moat: Build = i
		var cell: Cell = Helper.get_cell_by_build(moat)
		if cell == null:
			return
		var cells: Array[Cell] = Helper.get_cell_neighbours(cell)
		for j in cells:
			var packed_flood: PackedScene = Helper.get_packed_flood()
			if j.build != null:
				continue
			else:
				var random_number = randf()
				if random_number > 0.5:
					j.create_build(packed_flood.instantiate())
	pass
