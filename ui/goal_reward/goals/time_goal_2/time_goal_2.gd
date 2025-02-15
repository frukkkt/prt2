extends Goal

@onready var timer: Timer = $Timer

func enable():
	super.enable()
	progress_bar.value = 0
	progress_bar.max_value = goal_value * 60

func disable():
	if timer.timeout.is_connected(_on_timer_timeout):
		timer.timeout.disconnect(_on_timer_timeout)
	timer.stop()

func prepare():
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _on_timer_timeout():
	progress_bar.value += 1
	if progress_bar.value >= progress_bar.max_value:
		reward_player()

func reward_player():
	super.reward_player()
	Helper.get_message_system().create_message_of_unlocking_new_build("thanks for playing the demo, if you liked it write about it and I will know what to make more content.")
	emit_signal("finished")
