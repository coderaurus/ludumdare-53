extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var company_name = ""

onready var win_one = $"../Window2"
onready var win_two = $"../Window3"

var next_windows = []
var next = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	next_windows = [win_one, win_two]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _next():
	next_windows[next].rect_position = rect_position
	next += 1
	pass # Replace with function body.


func _begin():
	get_parent().visible = false
	get_parent().rect_position = Vector2.UP * 2000
	company_name = $"../Window3/TextEdit".text
	System.game.start_game(company_name)
	pass # Replace with function body.
