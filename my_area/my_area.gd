class_name MyArea2d
extends Area2D

signal enemy_entered(enemy)
signal enemy_exited(enemy)

signal player_entered(player)
signal player_exited(player)


func _on_body_entered(body: Node2D) -> void:
	var enemy = Helper.parent_is_enemy(body)
	if enemy != null:
		emit_signal("enemy_entered", enemy)
	
	var player = Helper.parent_is_player(body)
	if player != null:
		emit_signal("player_entered", player)



func _on_body_exited(body: Node2D) -> void:
	var enemy = Helper.parent_is_enemy(body)
	if enemy != null:
		emit_signal("enemy_exited", enemy)
	
	var player = Helper.parent_is_player(body)
	if player != null:
		emit_signal("player_exited", player)
