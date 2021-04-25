extends KinematicBody2D

export (int) var speed = 1
export (int) var tile_size = 20

func _ready() -> void:
	#position += Vector2.ONE * tile_size/2
	pass

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		position += Vector2.UP * speed
		
	if Input.is_action_pressed("ui_down"):
		position += Vector2.DOWN * speed
			
	if Input.is_action_pressed("ui_left"):
		position += Vector2.LEFT * speed
	if Input.is_action_pressed("ui_right"):
		position += Vector2.RIGHT * speed
	position = position.snapped(Vector2.ONE * tile_size)
	move_and_slide(position*speed)
