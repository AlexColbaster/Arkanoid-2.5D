extends Sprite3D

@onready var viewp = $SubViewport
@onready var cam = $SubViewport/Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewp.world_2d = get_viewport().world_2d
	texture = viewp.get_texture()
	
