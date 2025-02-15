extends Node2D

signal build_added(build)
signal build_destroyed(build)
signal builds_changed()

signal enemy_added(enemy)
signal enemy_died(enemy)
signal enemies_changed()
signal enemy_died_by(dealer)

signal build_card_added(build_card)
signal build_card_deleted(build_card)
signal build_cards_changed()
signal build_destroyed_by(dealer)
signal base_build_added()

signal main_scene_ready()
signal level_reloaded()
