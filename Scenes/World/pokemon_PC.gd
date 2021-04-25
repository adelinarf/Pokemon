extends Area2D

var collide = false
var dialog_number = 0
var dialog = ["You turned on the PC","Which PC do you wanna access?"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Dialog_.visible = true

var button_has_been_pressed = null
func _on_Dialog__button_changed(new_value) -> void:
	print (new_value,"PRINTEO DEL BOTON")
	button_has_been_pressed = new_value

func show_pc():
	if collide == true:
		if Input.is_action_just_pressed("ui_accept"):
			$Dialog_.visible = true
			if dialog_number >= len(dialog):
				$Dialog_.visible = true
				$Dialog_/GridContainer/Button.text = "Exit"
				$ItemList.visible = true
				$ItemList.clear()
				$ItemList.add_item(String(PlayerData.player_test["name"])+"'s"+" PC")
				$ItemList.add_item("Bill's PC")
				$ItemList.add_item("Prof. Oak's PC")
				$ItemList.add_item("Exit")
				if button_has_been_pressed == true:
					$ItemList.visible = false
					$Dialog_.visible = false
			else:
				$Dialog_/GridContainer/Label.text = dialog[dialog_number]
				dialog_number = (dialog_number + 1)
			
func _process(delta: float) -> void:
	show_pc()

func _on_Character_area_entered(area: Area2D) -> void:
	collide = true

func _on_Character_area_exited(area: Area2D) -> void:
	collide = false
	dialog_number = 0

func _on_ItemList_item_selected(index: int) -> void:
	var name = $ItemList.get_item_text(index)
	if name == String(PlayerData.player_test["name"])+"'s"+" PC":
		pass
	elif name == "Bill's PC":
		pass
	elif name == "Prof. Oak's PC":
		pass
	else:
		$ItemList.visible = false
		$Dialog_.visible = false
