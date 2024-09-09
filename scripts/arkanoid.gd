extends Node2D

var width := 0


var brick = load("res://scenes/brick.tscn")

@export var start_brick_pos := Vector2()
var brick_columns := 1
@export var separation_x := 1
@export var separation_y := 1
@onready var bg := $BG
@onready var right_wall := $RightWall
@onready var left_wall := $LeftWall
@onready var up_wall := $UpWall
@onready var up_wall_col := $UpWall/CollisionShape2D
@onready var deadzone := $Deadzone
@onready var deadzone_col := $Deadzone/CollisionShape2D

func _ready() -> void:
	await get_parent().ready
	width = get_parent().width
	bg.size.x = width
	brick_columns = (width - start_brick_pos.x * 2) / separation_x + 1
	right_wall.position.x = width
	up_wall_col.shape.size.x = width
	up_wall.position.x = width / 2
	deadzone_col.shape.size.x = width
	deadzone.position.x = width / 2
	for i in brick_columns:
		for j in 4:
			if randi() % 3 == 0:
				var br = brick.instantiate()
				br.position = start_brick_pos + Vector2(i*separation_x, j*separation_y)
				add_child(br)

	
	
	
