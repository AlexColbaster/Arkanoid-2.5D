extends Node3D

var viewp_count = Singleton.lvl + 2
var viewp_inst = load("res://scenes/viewport.tscn")
var width := 0.0
@export var side := 0.0
@onready var cam_par := $CameraParent
@onready var cam := $CameraParent/Camera3D

func _ready() -> void:
	%Lvl.text = "Уровень: "+str(Singleton.lvl)
	width = side * viewp_count
	cam.position.z
	var radius_inscribed_circle := side / (2 * tan(PI / viewp_count)) / 100
	cam.position.z = side / (2 * sin(PI / viewp_count)) / 100 + 5
	var vect := Vector3(radius_inscribed_circle, 0, 0)
	var deg = 0
	for i in viewp_count:
		var viewp = viewp_inst.instantiate()
		add_child(viewp)
		viewp.position = vect.rotated(Vector3.UP, deg)
		viewp.rotation.y = deg + PI/2
		viewp.cam.position.x += i*side
		deg += 2 * PI / viewp_count
	
func update_camera(player_pos:int):
	cam_par.rotation.y = 2 * PI / (width / (player_pos - side/2)) + PI / 2

func _process(delta: float) -> void:
	if not get_tree().get_nodes_in_group("brick"):
		%Finish.visible = true
		%Result.text = "ПОБЕДА!!!"
		%Next.visible = true


func _on_next_pressed() -> void:
	Singleton.lvl += 1
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
