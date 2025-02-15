extends Node2D

@export var damage: int = 1

func _ready() -> void:
	Helper.create_audio(Helper.get_sword_attack_mp3(), "SFX")
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation", 2 * PI, 0.4)
	await tween.finished
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	var parent = body.get_parent()
	if parent.is_in_group("enemy"):
		var enemy: Enemy = parent
		enemy.take_damage(damage, self)
