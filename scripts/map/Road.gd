extends Line2D

class_name Road

export var s_path_a : NodePath # settlement node
onready var s_node_a = get_node(s_path_a)

export var s_path_b : NodePath # settlement node
onready var s_node_b = get_node(s_path_b)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init():
	print("%s %s" % [s_node_a.position, s_node_b.position])
	add_point(s_node_a.position)
	add_point(s_node_b.position)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func disable():
	width = 1


func enable():
	width = 2.5


# Disable road from routing
func deselect():
	var color = Color.white
	color.a = 0.6
	set_default_color(color)
	

func select():
	var color = Color.greenyellow
	color.a = 0.6
	set_default_color(color)
