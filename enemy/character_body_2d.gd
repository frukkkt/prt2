extends CharacterBody2D

func _ready() -> void:
	Events.builds_changed.connect(try_find_target)
	try_find_target()

func try_find_target():
	#await get_tree().process_frame # время для того чтобы queue_free в build сработало 
	#var closest_build: Build = Helper.get_clossest_but_not_in_group(self, Helper.get_builds(), "ignored_targeting_build")
	var closest_build = get_tree().get_first_node_in_group("base")
	if closest_build != null:
		target = closest_build
	else:
		print_debug("closest_build eq null")

var target: Node2D = null
var speed: float: get = get_speed

func get_speed(): return get_parent().speed

func _physics_process(delta: float) -> void:
	if target != null:
		var direction = (target.global_position - global_position).normalized()
		
		velocity = direction * speed
		
		move_and_slide()
