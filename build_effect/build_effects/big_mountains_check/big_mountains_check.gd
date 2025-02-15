extends BuildEffect

func _ready() -> void:
	effect()

func effect():
	var builds: Array[Build] = Helper.get_build_neighbours(build, true)
	for i in builds:
		if i.is_in_group("mountains"):
			for j in i.effects:
				if j.is_in_group("big_mountains_check"):
					j.check_on_big_mountains()
	check_on_big_mountains()

func check_on_big_mountains():
	var mointains: int = 0
	var builds: Array[Build] = Helper.get_build_neighbours(build, true)
	for b in builds:
		if b.is_in_group("mountains"):
			mointains += 1
	if mointains == 8:
		transform_into_big_mountain()
	
var BIG_MOUNTAINS = load("res://build/builds/big_mountains/big_mountains.tscn")
func transform_into_big_mountain():
	var cell: Cell = Helper.get_cell_by_build(build)
	cell.create_build(BIG_MOUNTAINS.instantiate(), true)
