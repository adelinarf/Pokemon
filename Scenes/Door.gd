extends Area2D

export var kind_of_door = 0

export var next_scene : PackedScene


func _ready() -> void:
	$door.animation = String(kind_of_door)
	$door.frame = 0
	
func _get_configuration_warning() -> String:
	return "The next scene property can't be empty" if not next_scene else ""

func enter_building() -> void:
	get_tree().change_scene_to(next_scene)
	
func _on_Door_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		$door.playing = true
		enter_building()


func _on_Door_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		$door.playing = true
		enter_building()
