class_name MessageSystem
extends Control
@onready var new_build_unlocked: Panel = %NewBuildUnlocked
@onready var unlocked_build_name: Label = %UnlockedBuildName

func create_message_of_unlocking_new_build(build_name: String):
	get_tree().paused = true
	unlocked_build_name.text = build_name
	new_build_unlocked.show()
	show()


func _on_new_build_unlocked_ok_button_pressed() -> void:
	get_tree().paused = false
	new_build_unlocked.hide()
	hide()
