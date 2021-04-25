extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GridContainer/CheckBox.pressed = true

func _process(delta: float) -> void:
	pass


func _on_CheckBox_pressed() -> void:
	if Input.is_action_just_pressed("down"):
		print ("IS ENTERING")
		$GridContainer/CheckBox.pressed = false
		$GridContainer/CheckBox2.pressed = true

func _on_Button_pressed() -> void:
	$GridContainer/CheckBox.text = "BUTTON PRESSED"
