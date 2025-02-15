extends Goal

func enable():
	super.enable()
	progress_bar.value = 0
	progress_bar.max_value = 1
	
func prepare():
	Events.base_build_added.connect(_on_base_build_added)

func disable():
	if Events.base_build_added.is_connected(_on_base_build_added):
		Events.base_build_added.disconnect(_on_base_build_added)

func _on_base_build_added():
	progress_bar.value += 1
	reward_player()

func reward_player():
	super.reward_player()
	Score.gold += 10
	Score.crystalls += 10
	emit_signal("finished")
