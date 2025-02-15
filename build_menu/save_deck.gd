extends Node

func _ready() -> void:
	pass


func _on_next_button_button_up() -> void:
	var cards = get_tree().get_nodes_in_group("build_card_in_deck")
	var DECK = preload("uid://dnsitnqlbcp63")
	var packed_build: Array[PackedScene] = []
	for i in cards:
		packed_build.append(i.packed_build)
	DECK.packed_builds = packed_build
	
	get_tree().change_scene_to_file("uid://c1bra8vh378hy")
	Helper.create_audio(Helper.get_button_pressed_mp3())
