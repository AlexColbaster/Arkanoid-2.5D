extends CharacterBody2D

@export var speed = 0
var cool_down := 0.0
@onready var space_label = $"../%Space"

func _physics_process(delta: float) -> void:
	
	velocity = Vector2(Input.get_axis("left", "right") * speed, 0)
	move_and_slide()
	get_tree().current_scene.update_camera(position.x)
	if cool_down > 0:
		cool_down -= delta
		space_label.text = str(int(cool_down))
	else:
		space_label.text = "SPACE🧲"
	if Input.is_action_just_pressed("space") and cool_down <= 0:
		$"../Ball".rotation = $"../Ball".position.angle_to_point(position)
		cool_down = 15
	
	
