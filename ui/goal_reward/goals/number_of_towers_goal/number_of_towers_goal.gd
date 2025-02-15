extends Goal

@export var unlocked_build: PackedScene = null

func enable():
	super.enable()
	progress_bar.value = get_tree().get_nodes_in_group("tower").size()
	progress_bar.max_value = goal_value

func disable():
	if Events.build_added.is_connected(_on_build_added):
		Events.build_added.disconnect(_on_build_added)
	
func prepare():
	Events.build_added.connect(_on_build_added)

func _on_build_added(build: Build):
	if build.is_in_group("tower"):
		progress_bar.value += 1
		if progress_bar.value >= progress_bar.max_value:
			reward_player()

func reward_player():
	
	super.reward_player()
	Helper.add_build_in_available(unlocked_build)
	var build_name : String = get_build_name()
	Helper.get_message_system().create_message_of_unlocking_new_build(build_name)
	emit_signal("finished")

func get_build_name():
	return unlocked_build.instantiate().build_name
