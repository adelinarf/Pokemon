extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var scene = load("res://Scenes/World/Pallet Town.tscn")
onready var second_floor = preload("res://Scenes/World/Pallet Town/Hero home 2 floor.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Door.next_scene = scene
	$Stairs.next_scene = second_floor


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
