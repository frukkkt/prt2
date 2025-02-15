extends Node


func _on_slow_area_body_entered(body: Node2D) -> void:
	if Helper.parent_is_enemy(body):
		var enemy: Enemy = Helper.parent_is_enemy(body)
		enemy.speed /= 2


func _on_slow_area_body_exited(body: Node2D) -> void:
	if Helper.parent_is_enemy(body):
		var enemy: Enemy = Helper.parent_is_enemy(body)
		enemy.speed *= 2
