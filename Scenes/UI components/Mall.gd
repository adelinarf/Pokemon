extends Control

onready var money = get_node("Money")
onready var items = get_node("Mall_items")
onready var info = get_node("Info")
var object_selected = null
var dicc = {"Pokeball":"It can help you catch pokemon","Potion":"Use it to restore you HP","Super Pokeball":"Capture pokemon faster"}
onready var verification = get_node("GridContainer")
onready var verify_number = get_node("How_many")
onready var number_spin = get_node("How_many/SpinBox")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if PlayerData.player_test["Sprite"] == 0:
		$background.frame = 0
	else:
		$background.frame = 1
	money.text = money.text % String(PlayerData.player_test["Money"])
	items.clear()
	items.add_item("Pokeball")
	items.add_item("Potion")
	items.add_item("Super Pokeball")
	verification.visible = false
	verify_number.visible = false
	$alert.visible = false

func _on_Mall_items_item_selected(index: int) -> void:
	$alert.visible = false
	object_selected = items.get_item_text(index)
	info.text = dicc[object_selected]
	verification.visible = true
	
func _on_Yes_pressed() -> void:
	if verification.get_node("Yes").pressed == true:
		verification.get_node("No").pressed = false
	verification.visible = false
	verify_number.get_node("Label").text = "How many %s do you want?" % object_selected
	verify_number.visible = true
	verify_number.get_node("Label2").text = "Price to pay: %s" % String(0)

func _on_No_pressed() -> void:
	if verification.get_node("No").pressed == true:
		verification.get_node("Yes").pressed = false
	verification.visible = false
var prices = {"Pokeball":200,"Potion":100,"Super Pokeball":500}
func _on_SpinBox_changed() -> void:
	pass

var pay = 0
func _on_SpinBox_value_changed(value: float) -> void:
	var x = verify_number.get_node("Label2")
	var item_price = prices[object_selected]
	var price = number_spin.value * item_price
	x.text = "Price to pay: %s" % String(price)
	pay = price
#object_selected
var kind_of_item = 0

func item_type()->int:
	var value = 0     #GET 0 IF ITS A POKEBALL
					# GET 1 IF ITS A KEY ITEM
					# GET 2 IF ITS ANOTHER ITEM
	return (value)


func _on_Button_pressed() -> void:
	if number_spin.value == 0:
		pass
	else:
		if pay <= PlayerData.player_test["Money"]:
			for i in range(len(PlayerData.player_test["Bag"][0]["Content"])):
				if PlayerData.player_test["Bag"][kind_of_item]["Content"][i][0] == object_selected:
					PlayerData.player_test["Bag"][kind_of_item]["Content"][i][1] += number_spin.value
			PlayerData.player_test["Money"]-= pay
		else:
			$alert.visible = true
	verify_number.visible = false
	money.text = "Money: %s" % String(PlayerData.player_test["Money"])

func _on_Exit_pressed() -> void:
	pass # Replace with function body.
	#when the pokemon center scene is ready go back to it
