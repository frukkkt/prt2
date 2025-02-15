@tool
extends Sprite2D
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D

func _ready() -> void:
	if not Engine.is_editor_hint():
		return
		set_attack_radius_sprite()

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		set_attack_radius_sprite()

func set_attack_radius_sprite():
	var _texture: GradientTexture2D = texture
	var shape: CircleShape2D = collision_shape_2d.shape
	_texture.width = collision_shape_2d.shape.radius * 2
	_texture.height = collision_shape_2d.shape.radius * 2
