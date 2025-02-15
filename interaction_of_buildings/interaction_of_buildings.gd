extends Node
const INTERACTIONS = preload("uid://c6eg6yb6uplki")
func _ready() -> void:
	Events.builds_changed.connect(_on_builds_changed)

func _on_builds_changed():
	for cell in Helper.get_cells():
		var build = cell.build
		if build == null:
			continue
		if build.is_in_group("gold_mine"):
			for neighbour in cell.neighbours:
				var neighbour_build = neighbour.build
				if neighbour_build == null: continue
				if neighbour_build.is_in_group("tower"):
					var tower = neighbour_build
					add_gold_effect_to_tower(tower)

func add_gold_effect_to_tower(tower: Build):
	var gold_tower_effect = preload("uid://bwnq20miy4o8b").instantiate()
	tower.add_effect(gold_tower_effect, true)
				

func get_build_by_group(cell: Cell, group: String) -> Build:
	if cell.build != null:
		if cell.build.is_in_group(group):
			return cell.build
	return null

func get_group_cell_map(cells: Array[Cell], groups: Array[String]):
	var group_cell: Dictionary = {}
	var index = 0
	for cell in cells:
		if cell.build != null:
			if cell.build.is_in_group(groups[index]):
				group_cell[groups[index]] = cell
				index += 1
				continue
	return group_cell
