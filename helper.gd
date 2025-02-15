extends Node

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

const BUILDS = preload("res://build/builds.tres")
func get_nodes_in_group_in_node(node: Node, group: String) -> Array:
	var nodes_in_group: Array = []
	for i in node.get_children():
		if i.is_in_group(group):
			nodes_in_group.append(i)
	return nodes_in_group
		

func get_build_cards() -> Array[BuildCard]:
	var array: Array[BuildCard] = []
	var pre_array = get_tree().get_nodes_in_group("build_card")
	array.assign(pre_array)
	return array

func get_build_buy_cards() -> Array[BuildBuyCard]:
	var array: Array[BuildBuyCard] = []
	var pre_array = get_tree().get_nodes_in_group("build_buy_card")
	array.assign(pre_array)
	return array

func get_enemies() -> Array[Enemy]:
	var array: Array[Enemy] = []
	var pre_array = get_tree().get_nodes_in_group("enemy")
	array.assign(pre_array)
	return array

func get_cells() -> Array[Cell]:
	return CellPool.cells

func get_cell_by_build(build: Build) -> Cell:
	var cells: Array[Cell] = get_cells()
	for cell in cells:
		if cell.build == build:
			return cell
	return null

func get_neighbours(index: int, diagonales: bool = false) -> Array:
	var neighbours = []
	var columns = 36
	var rows = 20

	# Определяем строку и колонку текущей ячейки
	var row = index / columns
	var col = index % columns

	# Возможные смещения для соседей (верх, низ, слева, справа, диагонали)
	var directions = [
		Vector2(-1, 0),  # слева
		Vector2(1, 0),   # справа
		Vector2(0, -1),  # сверху
		Vector2(0, 1),   # снизу
	]
	if diagonales == true:
		directions += [
			Vector2(1, 1),
			Vector2(-1, 1),
			Vector2(-1, -1),
			Vector2(1, -1)
		]

	# Проверяем каждое направление
	for direction in directions:
		var neighbour_row = row + direction.y
		var neighbour_col = col + direction.x

		# Проверяем, что сосед находится в пределах сетки
		if neighbour_row >= 0 and neighbour_row < rows and neighbour_col >= 0 and neighbour_col < columns:
			var neighbour_index = int(neighbour_row * columns + neighbour_col)
			neighbours.append(neighbour_index)

	return neighbours

func get_cell_neighbours(cell: Cell, diagonales: bool = false) -> Array[Cell]:
	var cells: Array[Cell] = get_cells()
	if cells == []: return []
	
	var neighbours_index = get_neighbours(cells.find(cell), diagonales)
	var cell_neighbours: Array[Cell] = []
	for i in neighbours_index:
		cell_neighbours.append(cells[i])
	return cell_neighbours

func get_build_neighbours(build: Build, diagonales: bool = false) -> Array[Build]:
	var cell: Cell = get_cell_by_build(build)
	var cells: Array[Cell] = get_cell_neighbours(cell, diagonales)
	var builds: Array[Build] = []
	for i in cells:
		var cell_build: Build = i.build
		if cell_build == null:
			continue
		else:
			builds.append(cell_build)
	return builds


func get_builds() -> Array[Build]:
	var array: Array[Build] = []
	var pre_array = get_tree().get_nodes_in_group("build")
	array.assign(pre_array)
	return array 

func get_closest(node: Node2D, targets: Array):
	if targets == []:
		#print_debug("targets eq []")
		return null
	var distances_targets := {}
	for target in targets:
		if is_instance_valid(target) == false:
			pass
			#print_debug("target not valid")
		if target is Node2D:
			var distance_to_target = node.global_position.distance_to(target.global_position)
			distances_targets[distance_to_target] = target
	var min_distance = distances_targets.keys().min()
	var closets_target = distances_targets[min_distance]
	return closets_target

func get_clossest_but_not_in_group(node: Node2D, targets: Array, group: String):
	if targets == []:
		#print_debug("targets eq []")
		return null
	var distances_targets := {}
	for target in targets:
		if is_instance_valid(target) == false:
			pass
			#print_debug("target not valid")
		if target.is_in_group(group): continue
		if target is Node2D:
			var distance_to_target = node.global_position.distance_to(target.global_position)
			distances_targets[distance_to_target] = target
	if distances_targets == {}:
		return
	var min_distance = distances_targets.keys().min()
	var closets_target = distances_targets[min_distance]
	return closets_target

func add_build_card(build_card: BuildCard):
	var build_card_container: BuildCardContainer = get_tree().get_first_node_in_group("build_card_container")
	build_card_container.add_build_card(build_card)

func get_build_card_from_build_buy_card(build_buy_card: BuildBuyCard):
	var build_card: Card = load("uid://dvfppfwk88b75").instantiate()
	build_card.packed_build = build_buy_card.packed_build
	return build_card

func parent_is_player(body: Node2D) -> Player:
	var parent = body.get_parent()
	if parent.is_in_group("player"):
		return parent
	else:
		return null

func parent_is_enemy(body: Node2D) -> Enemy:
	var parent = body.get_parent()
	if parent.is_in_group("enemy"):
		return parent
	else:
		return null

func get_cost_by_packed_build(packed_build: PackedScene):
	if packed_build == null: return null
	var CARD_COST = load("uid://bwenwerorm4pc")
	return CARD_COST.card_cost[packed_build].cost

func get_cost_resource_by_packed_build(packed_build: PackedScene):
	if packed_build == null: return Constants.CostResource.NULL
	var CARD_COST = load("uid://bwenwerorm4pc")
	return CARD_COST.card_cost[packed_build].resource

func get_build_card_by_packed_build(packed_build: PackedScene):
	var BUILD_CARD = load("uid://dvfppfwk88b75")
	var build_card: BuildCard = BUILD_CARD.instantiate()
	build_card.packed_build = packed_build
	return build_card

#region Builds

func get_packed_gold_mine() -> PackedScene:
	return load("uid://cx0ijvmpkucsm")

func get_packed_flood() -> PackedScene:
	return BUILDS.scene_dict['flood']

#endregion

#region EnemySpawner

func get_enemy_spawner() -> EnemySpawner:
	var enemy_spawner: EnemySpawner = get_tree().get_first_node_in_group("enemy_spawner")
	return enemy_spawner

func stop_enemy_spawning(time: float):
	var enemy_spawner: EnemySpawner = get_enemy_spawner()
	enemy_spawner.stop_spawning()
	await get_tree().create_timer(time).timeout
	enemy_spawner.start_spawning()

func spawn_enemy(enemy: Enemy, pos: int = -1):
	get_enemy_spawner().create_enemy(enemy, pos)
#endregion

#region Audio, Sound, Music

var audio_value: int = 0
func create_audio(audio: AudioStream, bus: String = "Master", is_limited: bool = false):
	if audio_value >= 15 and is_limited:
		return
	var root = get_tree().root
	var audio_stream_player := AudioStreamPlayer.new()
	audio_stream_player.bus = bus
	audio_stream_player.stream = audio
	audio_stream_player.process_mode = Node.PROCESS_MODE_ALWAYS
	root.add_child(audio_stream_player)
	audio_stream_player.call_deferred('play')
	if is_limited:
		audio_value += 1
	audio_stream_player.finished.connect(audio_stream_player_finished.bind(audio_stream_player, is_limited))

func audio_stream_player_finished(audio_stream_player, is_limited):
	audio_stream_player.queue_free()
	if is_limited:
		audio_value -= 1
	

const ALL_MP_3 = preload("res://mp3_pool/all_mp3.tres")
# ТО что ниже это легаси, долго переделывать. Правильнееп так: Helper.create_audio(Helper.ALL_MP3[нужная_музыка])
func get_button_pressed_mp3() -> AudioStream:
	return ALL_MP_3.all_mp3["button_pressed"]

func get_build_created_mp3() -> AudioStream:
	return ALL_MP_3.all_mp3["build_created"]

func get_enemy_hit_mp3() -> AudioStream:
	return ALL_MP_3.all_mp3["enemy_hit"]

func get_enemy_dead_mp3() -> AudioStream:
	return ALL_MP_3.all_mp3["enemy_death"]

func get_win_mp3() -> AudioStream:
	return ALL_MP_3.all_mp3["win"]

func get_lose_mp3() -> AudioStream:
	return ALL_MP_3.all_mp3["lose"]

func get_buy_sell_mp3() -> AudioStream:
	return ALL_MP_3.all_mp3["buy_sell"]

func get_new_card_unlocked_mp3() -> AudioStream:
	return ALL_MP_3.all_mp3["win"]

func get_resource_colleted_mp3() -> AudioStream:
	return ALL_MP_3.all_mp3["res_collected"]



#endregion

func get_message_system() -> MessageSystem:
	return get_tree().get_first_node_in_group("message_system")


var lmb_pressed: bool = false
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				lmb_pressed = true
			else:
				lmb_pressed = false

var AVAILABLE_CARD = load("res://build_menu/available_card.tres")
func add_build_in_available(packed_build: PackedScene):
	AVAILABLE_CARD.available_cards.append(packed_build)
