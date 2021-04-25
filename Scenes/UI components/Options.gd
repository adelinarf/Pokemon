extends Control

onready var text_choose = get_node("GridContainer/OptionButton")
onready var sound_choose = get_node("GridContainer/OptionButton2")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_choose.add_item("Slow")
	text_choose.add_item("Quick")
	
func _on_HSlider_value_changed(value: float) -> void:
	pass # CHANGE OVERALL VOLUME

func _on_OptionButton_item_selected(index: int) -> void:
	pass # CHANGE TEXT ANIMATION SPEED

func _on_Button_pressed() -> void:
	get_tree().change_scene(PlayerData.is_in[1])
	 # GO BACK TO THE PAUSED SCREEN
