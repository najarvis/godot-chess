extends Node2D

var pawnScene = preload("res://pieces/pawn.tscn")
var rookScene = preload("res://pieces/rook.tscn")
var bishopScene = preload("res://pieces/bishop.tscn")
var knightScene = preload("res://pieces/knight.tscn")
var kingScene = preload("res://pieces/king.tscn")
var queenScene = preload("res://pieces/queen.tscn")

# Replace with FEN or other system later
var piece_info = {
	"pawn": [
		[[1,2], [2,2], [3,2], [4,2], [5,2], [6,2], [7,2], [8, 2]],
		[[1,7], [2,7], [3,7], [4,7], [5,7], [6,7], [7,7], [8, 7]]
	],
	"rook": [
		[[1,1], [8,1]],
		[[1,8], [8,8]]
	],
	"knight": [
		[[2,1], [7,1]],
		[[2,8], [7,8]]
	],
	"bishop": [
		[[3,1], [6,1]],
		[[3,8], [6,8]]
	],
	"king": [
		[[4,1]],
		[[4,8]]
	],
	"queen": [
		[[5,1]],
		[[5,8]]
	]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_pieces()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate_pieces():
	for piece in piece_info:
		for white_piece_coord in piece_info[piece][0]:
			add_piece(piece, true, arr_to_vec2i(white_piece_coord))
		for black_piece_coord in piece_info[piece][1]:
			add_piece(piece, false, arr_to_vec2i(black_piece_coord))

func arr_to_vec2i(arr) -> Vector2i:
	return Vector2i(arr[0], arr[1])

func board_to_screen_coords(board_coord: Vector2i) -> Vector2i:
	return Vector2i((board_coord.x - 1) * 8,
					(8 - board_coord.y) * 8)
				
func add_piece(type: String, isWhite: bool, position: Vector2i):
	var scene = null
	match(type):
		"pawn":
			scene = pawnScene
		"rook":
			scene = rookScene
		"knight":
			scene = knightScene
		"bishop":
			scene = bishopScene
		"queen":
			scene = queenScene
		"king":
			scene = kingScene
	
	var new_piece = scene.instantiate()
	new_piece.get_node("Sprite2D").material.set_shader_parameter("isWhite", isWhite)
	new_piece.transform = new_piece.transform.translated(board_to_screen_coords(position))
	add_child(new_piece)
