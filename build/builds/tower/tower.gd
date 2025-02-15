class_name Tower
extends Build

signal fire_started()
signal fire_ended()

@onready var attack_cooldown: Timer = $AttackCooldown
@onready var attack_radius: Area2D = $AttackRadius

@export var damage: int = 2

func _on_attack_cooldown_timeout() -> void:
	if attack_radius.has_overlapping_bodies():
		var enemies: Array[Enemy] = []
		for body in attack_radius.get_overlapping_bodies():
			var enemy = Helper.parent_is_enemy(body)
			if enemy != null:
				enemies.append(enemy)
		var closest_enemy = Helper.get_closest(self, enemies)
		fire(closest_enemy)

func fire(target):
	if target == null:
		return
	emit_signal("fire_started")
	target.take_damage(damage, self)
	emit_signal("fire_ended")
