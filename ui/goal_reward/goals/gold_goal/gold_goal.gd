extends Goal

@export var unlocked_build: PackedScene

func enable():
	super.enable()
	progress_bar.max_value = Score.gold + goal_value
	progress_bar.value = Score.gold

func disable():
	if Score.gold_changed.is_connected(_on_gold_chaned):
		Score.gold_changed.disconnect(_on_gold_chaned)
	if progress_bar.value_changed.is_connected(_on_progress_bar_value_changed):
		progress_bar.value_changed.disconnect(_on_progress_bar_value_changed)

func prepare() -> void:
	Score.gold_changed.connect(_on_gold_chaned)
	progress_bar.value_changed.connect(_on_progress_bar_value_changed)

func _on_gold_chaned():
	progress_bar.value = Score.gold

func _on_progress_bar_value_changed(value: float):
	if value == progress_bar.max_value:
		reward_player()

func reward_player():
	super.reward_player()
	Helper.add_build_in_available(unlocked_build)
	var build_name : String = get_build_name()
	Helper.get_message_system().create_message_of_unlocking_new_build(build_name)
	emit_signal("finished")

func get_build_name():
	return unlocked_build.instantiate().build_name
