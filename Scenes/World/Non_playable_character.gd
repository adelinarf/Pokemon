extends Area2D


var dialog = ["Hi welcome to the pokemon center","Here we can give life to your pokemon"]
signal change_dialog(value)
signal show_dialog(value)
var show_dialogs = false setget set_show_dialog
var dialog_number = 0 setget set_dialog
var collide = false
export var number_of_character = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_dialog(value):
	dialog_number = value
	emit_signal("change_dialog",dialog_number)
	
func set_show_dialog(value):
	show_dialogs = value
	emit_signal("show_dialog",show_dialogs)

func change_dialog():
	if collide == true:
		if Input.is_action_just_pressed("ui_accept"):
			self.show_dialogs = true
			if dialog_number >= len(dialog):
				self.show_dialogs = false
			else:
				if number_of_character == 0:
					self.dialog_number = (self.dialog_number + 1)
				else:
					self.dialog_number = (self.dialog_number + 1)%len(dialog)
	else:
		self.dialog_number = 0
				
func _process(delta: float) -> void:
	change_dialog()

func _on_Character_area_entered(area: Area2D) -> void:
	collide = true

func _on_Character_area_exited(area: Area2D) -> void:
	collide = false
	self.dialog_number = 0
