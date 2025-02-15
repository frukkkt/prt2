extends Node

var cells: Array[Cell] = []

func _ready() -> void:
	update_cells()
	
	Events.main_scene_ready.connect(_main_scene_ready)

func _main_scene_ready():
	update_cells()

func update_cells():
	#await Events.main_scene_ready
	var array: Array[Node] = get_tree().get_nodes_in_group("cell")
	cells.assign(array)
