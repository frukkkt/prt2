@tool
extends Resource

@export var goal_finished: Dictionary = {}
@export var update: bool = false: set = set_update

func set_update(_bool):
	dir_contents("res://ui/goal_reward/goals")
	update = false

func dir_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				#print_debug("Found directory: " + file_name)
				var scene_path = "%s/%s/%s.gd" % [path, file_name, file_name]
				goal_finished[scene_path] = false
			else:
				#print_debug("Found file: " + file_name)
				pass
			file_name = dir.get_next()
	else:
		#print_debug("An error occurred when trying to access the path.")
		pass
