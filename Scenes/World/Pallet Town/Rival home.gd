extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var scene = load("res://Scenes/World/Pallet Town.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Door.next_scene = scene


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

