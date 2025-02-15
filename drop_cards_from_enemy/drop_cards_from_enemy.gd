extends Node

func _ready() -> void:
	Events.enemy_died.connect(_on_enemy_died)

func _on_enemy_died(enemy: Enemy):
	var random_number = randf_range(0, 1)
	if random_number < 0.1:
		drop_gold_card()

func drop_gold_card():
	var packed_gold_mine: PackedScene = Helper.get_packed_gold_mine()
	var build_card: BuildCard = Helper.get_build_card_by_packed_build(packed_gold_mine)
	Helper.add_build_card(build_card)
	
	Helper.create_audio(Helper.get_new_card_unlocked_mp3(), "SFX")
