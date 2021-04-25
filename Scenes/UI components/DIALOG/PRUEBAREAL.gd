extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var dialog = get_node("Dialog_box")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog.visible = false

func _process(delta: float) -> void:
	dialog.change_dialog()
	print (PlayerData.is_colliding_with)
