extends Goal

@export var gold_reward: int = 200

func enable():
	super.enable()
	progress_bar.max_value = Score.crystalls + goal_value
	progress_bar.value = Score.crystalls

func disable():
	if Score.crystalls_changed.is_connected(_on_crystalls_changed):
		Score.crystalls_changed.disconnect(_on_crystalls_changed)
	if progress_bar.value_changed.is_connected(_on_progress_bar_value_changed):
		progress_bar.value_changed.disconnect(_on_progress_bar_value_changed)

func prepare() -> void:
	Score.crystalls_changed.connect(_on_crystalls_changed)
	progress_bar.value_changed.connect(_on_progress_bar_value_changed)

func _on_crystalls_changed():
	progress_bar.value = Score.crystalls

func _on_progress_bar_value_changed(value: float):
	if value == progress_bar.max_value:
		reward_player()

func reward_player():
	super.reward_player()
	Score.gold += gold_reward
	emit_signal("finished")
