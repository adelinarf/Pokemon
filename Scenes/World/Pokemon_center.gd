extends Node2D

onready var dialogs = get_node("Dialog_/GridContainer/Label")
var dialog = ["Hi welcome to the pokemon center","Here we can give life to your pokemon"]
var button_has_been_pressed = false
var dialog_number = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass #change_dialog()
	
func change_dialog():
	if PlayerData.colliding == true:
		if Input.is_action_just_pressed("ui_accept"):
			if dialog_number >= len(dialog):
				$Dialog_.visible = false
				$Healing.visible = true
			else:
				dialogs.text = dialog[dialog_number]
				dialog_number+=1
				
		
func _on_Area2D_area_entered(area: Area2D) -> void:
	PlayerData.colliding = true
		
func _on_Dialog__button_changed(new_value) -> void:
	button_has_been_pressed = new_value

func _on_Area2D_body_exited(body: Node) -> void:
	PlayerData.colliding = false
	
var selected = null
func _on_CheckBox_pressed() -> void:
	if $Healing/CheckBox.pressed == true:
		$Healing/CheckBox2.pressed = false
	selected = "yes"

func _on_CheckBox2_pressed() -> void:
	if $Healing/CheckBox2.pressed == true:
		$Healing/CheckBox.pressed = false
	selected = "no"

func _on_Button_pressed() -> void:
	if selected == "no":
		$Healing.visible = false
		dialogs.text = "Be right back when you need it"
		if button_has_been_pressed == true:
			$Dialog_.visible = false
	elif selected == "yes":
		$Healing.visible = false
		$Dialog_.visible = true
		dialogs.text = "We're healing your pokemon"
		# INSERT A FUNCTION TO HEAL EVERY POKEMON
		dialogs.text = "We're done with your pokemon be right back when you need it"
		if button_has_been_pressed == true:
			$Dialog_.visible = false
			

func _on_Character_change_dialog(value) -> void:
	dialog_number = value

func _on_Character_show_dialog(value) -> void:
	$Dialog_.visible = value
