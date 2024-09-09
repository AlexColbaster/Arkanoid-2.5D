extends CharacterBody2D

const SPEED = 500
@onready var hp_label = $"../%HP"
@onready var pl = $"../Player"
@onready var line = $Line2D
@onready var ray1 = $Ray1
@onready var ray2 = $Ray2

func _ready() -> void:
	while not get_tree().get_nodes_in_group("brick"):
		await get_tree().process_frame
	for brick in get_tree().get_nodes_in_group("brick"):
		ray1.add_exception(brick)
		ray2.add_exception(brick)
	ray1.add_exception(self)


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("space"):
		line.visible = true
		ray1.global_rotation = 0
		ray2.global_rotation = 0
		line.global_rotation = 0
		ray1.target_position = pl.position - position
		
		if ray1.get_collider():
			var point = ray1.get_collision_point()
			ray2.global_position = point
			ray2.target_position = Vector2(ray1.target_position.x, -ray1.target_position.y).normalized() * 1200
			line.points = [Vector2(), point-global_position, ray2.get_collision_point()-global_position]
	else:
		line.visible = false
	var movement = Vector2.RIGHT.rotated(rotation) * SPEED * delta
	var colision := move_and_collide(movement)
	
	if colision:
		if not colision.get_collider() is CollisionObject2D:
			return 
		rotation = Vector2.from_angle(rotation).bounce(colision.get_normal()).angle()
		if colision.get_collider().is_in_group("brick"):
			colision.get_collider().queue_free()
			$"../%Score".text = str(int($"../%Score".text) + 1)
		if colision.get_collider().is_in_group("dead"):
			
			var hp = hp_label.text.count("❤️")
			hp -= 1
			if hp == 0:
				$"../%Finish".visible = true
				$"../%Result".text = "ПОРАЖЕНИЕ"
			else:
				var hp_str = ""
				for i in hp:
					hp_str += "❤️"
				hp_label.text = hp_str
				position = pl.position - Vector2(0, 100)
				rotation = -PI * 0.51
				
			
		
