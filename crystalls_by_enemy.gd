extends Node

func _ready() -> void:
	Events.enemy_died_by.connect(_on_enemy_died_by)

func _on_enemy_died_by(dealer: Node):
	if dealer.is_in_group("player") or dealer.is_in_group("tower") or dealer.is_in_group("sword"):
		Score.crystalls += 1
		Helper.create_audio(Helper.get_resource_colleted_mp3(), "SFX")
