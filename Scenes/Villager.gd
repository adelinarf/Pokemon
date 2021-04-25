extends Area2D

var tile_size = 20
var inputs = {"right": Vector2.RIGHT.clamped(0.2),
			"left": Vector2.LEFT.clamped(0.2),
			"up": Vector2.UP.clamped(0.2),
			"down": Vector2.DOWN.clamped(0.2)}
onready var sprite = $Sprite

func _ready() -> void:
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2

func _unhandled_input(event):
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			move_right()

func move_down(dir):
	position += inputs["down"] * tile_size
	
func move_right():
	position += inputs["right"] * tile_size
	
func move_left():
	position += inputs["left"] * tile_size

func move_up():
	position += inputs["up"] * tile_size
