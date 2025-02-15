extends Panel
@onready var v_box_container: VBoxContainer = $VBoxContainer

func _ready() -> void:
	Events.enemies_changed.connect(_on_enemies_changed)

func _on_enemies_changed():
	v_box_container.get_children().map(
		func(c):\
			c.queue_free()
		)
	var enemies: Array[Enemy] = Helper.get_enemies()
	for i in enemies:
		var label := Label.new()
		label.text = str(i.enemy_name, i.hp)
		v_box_container.add_child(label)
