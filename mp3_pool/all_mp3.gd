@tool
extends Resource

@export var all_mp3: Dictionary = {}

@export var update: bool = false: set = set_update

func set_update(_bool):
	dir_contents("res://ui_sounds/mp3")
	update = false


func dir_contents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name: String = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				#print_debug("Found directory: " + file_name)
				pass
			else:
				var scene_path = "%s/%s" % [path, file_name]
				if scene_path.get_extension() == "import":
					pass
				else:
					#print_debug("Found file: " + scene_path)
					pass
					var dict_key = file_name.left(-4)
					var dict_value = load(scene_path)
					all_mp3[dict_key] = dict_value
					
			file_name = dir.get_next()
	else:
		pass
		#print_debug("An error occurred when trying to access the path.")
