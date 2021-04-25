extends Control
signal is_pressed(value)
onready var pause_menu = get_node("menu")
onready var pokedex = get_node("menu/Yes")
onready var pokemon = get_node("menu/No")
var directiony = [Vector2(816,64),Vector2(816,128)]
var pressed = 0 setget set_pressed

func _ready() -> void:
	pass

func set_pressed(value):
	pressed = value
	emit_signal("is_pressed",pressed)

func input_event_entered():
	if $selector.rect_position == directiony[0]:
		print ("Yes")
		self.pressed = 0
	elif $selector.rect_position == directiony[1]:
		self.pressed = 1
		print ("NO")
		
var posy = 0
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		if $selector.rect_position == directiony[(posy)%len(directiony)]:
			$selector.rect_position = directiony[(posy-1)%len(directiony)]
		posy=(posy-1)%len(directiony)
	elif event.is_action_pressed("down"):
		if $selector.rect_position == directiony[(posy)%len(directiony)]:
			$selector.rect_position = directiony[(posy+1)%len(directiony)]
		posy=(posy+1)%len(directiony)
	elif event.is_action_pressed("ui_accept"):
		input_event_entered()
	
func _on_Yes__pressed() -> void:
	pass # Replace with function body.

func _on_No_pressed() -> void:
	pass # Replace with function body.
