extends KinematicBody2D

export (int) var speed = 4
export (int) var tileSize = 20

var initial = Vector2()
var motion = Vector2()
var target = Vector2()

var d = 0

func _physics_process(delta):
	var value = d * speed
	if value >= 1: 
		value = 1
		d = 0
		
	self.position.x = lerp(initial.x, target.x, value)
	self.position.y = lerp(initial.y, target.y, value)
	
	if motion != Vector2():
		initial = self.position
		target = initial + motion
		motion = Vector2()
		
	elif self.position == target:
		initial = self.position
		if Input.is_action_pressed("ui_up"):
			motion = Vector2(0, -1) * tileSize
			
		if Input.is_action_pressed("ui_down"):
			motion = Vector2(0, 1) * tileSize
				
		if Input.is_action_pressed("ui_left"):
			motion = Vector2(-1, 0) * tileSize
			
		if Input.is_action_pressed("ui_right"):
			motion = Vector2(1, 0) * tileSize
		
	else:
		d += delta
