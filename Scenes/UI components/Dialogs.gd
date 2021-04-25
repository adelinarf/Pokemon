extends Control

onready var dia = get_node("AcceptDialog")
func _ready() -> void:
	dia.visible = true

signal button_dialog(value)
var dialog = false setget set_dialog

func set_dialog(value):
	dialog = true
	emit_signal("button_dialog",dialog)

func _on_AcceptDialog_confirmed() -> void:
	dialog = true
