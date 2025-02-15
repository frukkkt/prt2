@tool
extends Resource

@export var update: bool = false: set = set_update

func set_update(_bool):
	dir_contents("res://enemy_effects/effects")
	update = false

@export var all_enemy_effects: Dictionary = {}

func dir_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				#print_debug("Found directory: " + file_name)
				var scene_path = "%s/%s/%s.tscn" % [path, file_name, file_name]
				all_enemy_effects[file_name] = load(scene_path)
			else:
				#print_debug("Found file: " + file_name)
				pass
			file_name = dir.get_next()
	else:
		#print_debug("An error occurred when trying to access the path.")
		pass
