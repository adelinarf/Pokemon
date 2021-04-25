extends Area2D


var dialog = ["Hi welcome to the pokemon center","Here we can give life to your pokemon"]
signal change_dialog(value)
signal change_number(value)
var dialog_string = 0 setget set_dialog
var dialog_number = 0 setget set_number
var collide = false
export var number_of_character = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_number(value):
	dialog_number = value
	emit_signal("change_number",dialog_number)
	
func set_dialog(value):
	dialog_string = value
	emit_signal("change_dialog",dialog_string)

func change_dialog():
	if collide == true:
		if Input.is_action_just_pressed("ui_accept"):
			if self.dialog_number == len(dialog):
				pass
			else:
				self.dialog_string = dialog[(self.dialog_number)%len(dialog)]
				self.dialog_number += 1
	else:
		dialog_number = 0
				
func _process(delta: float) -> void:
	change_dialog()

func _on_Character_area_entered(area: Area2D) -> void:
	collide = true

func _on_Character_area_exited(area: Area2D) -> void:
	collide = false
	self.dialog_number = 0
