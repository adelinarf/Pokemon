extends Control

signal button_changed(new_value)
export var button_pressed = 100 setget _set_button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_Button_pressed() -> void:
	self.button_pressed = true
	
func _set_button(new_value)->void:
	button_pressed=new_value
	emit_signal("button_changed",button_pressed)
