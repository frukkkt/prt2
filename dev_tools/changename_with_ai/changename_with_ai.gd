extends Panel

var BUILDS = load("res://build/builds.tres")
@onready var grid_container: GridContainer = $GridContainer
@onready var transfer_card: Node = %TransferCard

func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)
	
func _on_visibility_changed():
	if visible == false:
		grid_container.get_children().map(func(x): x.queue_free())
	else:
		var index: int = 0
		for i in BUILDS.scene_dict.values():
			var packed_scene: PackedScene = i
			var build_card_in_storage: Card = load("res://build_menu/build_card_in_storage.tscn").instantiate()
			build_card_in_storage.packed_build = packed_scene
			grid_container.add_child(build_card_in_storage)
		transfer_card.connect_cards()
