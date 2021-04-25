extends TileMap


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var _tileset
var tileset_position = [[Vector2(-1,0),Vector2(-2,0),Vector2(-1,1),Vector2(-2,-1)],[Vector2(0,0),Vector2(0,1),Vector2(1,0),Vector2(1,1)],[Vector2(3,0),Vector2(3,1),Vector2(4,0),Vector2(4,1)]]
# Called when the node enters the scene tree for the first time.
var i = 2
func _ready() -> void:
	
	print (get_used_cells())
	self.set_cell(0, 0, i,false,false,false,tileset_position[i][0])
	self.set_cell(0, 1, i,false,false,false,tileset_position[i][1])
	self.set_cell(1, 0, i,false,false,false,tileset_position[i][2])
	self.set_cell(1, 1, i,false,false,false,tileset_position[i][3])
