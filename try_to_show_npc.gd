extends Area2D


var tile_size = 20
export var walking_left = false
export var walking_right = false
export var walking_up = false
export var walking_down = false
export var character = 1
var vector = Vector2(-tile_size,0).clamped(0.2)
var direction = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_walking()

func get_walking():
	if walking_down==true:
		vector = Vector2(0,tile_size).clamped(0.2)
		direction = "down"
	elif walking_left==true:
		vector = Vector2(-tile_size,0).clamped(0.2)
		direction = "left"
	elif walking_right==true:
		vector = Vector2(tile_size,0).clamped(0.2)
		direction = "right"
	elif walking_up == true:
		vector = Vector2(0,-tile_size).clamped(0.2)
		direction = "up"

func _process(delta: float) -> void:
	position += vector
	$AnimatedSprite.animation = String(character) + " walking " + direction
	$AnimatedSprite.playing = true 

func name()->int:
	return (character)
