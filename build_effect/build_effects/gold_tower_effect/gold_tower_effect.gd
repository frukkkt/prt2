extends BuildEffect

func _ready() -> void:
	effect()

func effect():
	var tower: Tower = build
	change_modulate_of_tower(tower)
	tower.damage += 1
	tower.fire_started.connect(_on_fire_started.bind(tower))
	
	get_tree().process_frame.connect(tower.shine, CONNECT_ONE_SHOT)

func _on_fire_started(tower: Tower):
	Score.gold -= 1


@export var tower_modulate: Color
func change_modulate_of_tower(tower: Tower):
	tower.modulate = tower_modulate
