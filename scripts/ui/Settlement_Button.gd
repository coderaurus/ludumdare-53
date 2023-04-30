extends Control

class_name Settlement_Button
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var s_path : NodePath # settlement node
onready var s_node = get_node(s_path)

onready var quest_marker = $QuestMarker
onready var event_marker = $EventMarker

# Called when the node enters the scene tree for the first time.
func _ready():
	$Name.text = s_node.settlement_name


func _process(delta):
	if rect_position != s_node.position:
		rect_position = s_node.position

func _open():
	print("Opening %s" % s_node)
	if System.game.UI.routing:
		_select()
	else:
		s_node.emit_signal("on_enter")


func _select():
	var tween = get_tree().create_tween()
	var selected = System.game.select_road(s_node)
	
	if selected:
		tween.tween_property(self, "rect_scale", Vector2.ONE * 1.2, 0.1)
	elif rect_scale != Vector2.ONE:
		tween.tween_property(self, "rect_scale", Vector2.ONE, 0.1)
	else:
		tween.kill()

func disable():
	$TextureButton.disabled = true
	$TextureButton.modulate = Color.darkgray


func enable():
	$TextureButton.disabled = false
	$TextureButton.modulate = Color.white


func pop_quest():
	quest_marker.visible = true
	
	
func pop_event():
	event_marker.visible = true
	
	
func hide_quest():
	quest_marker.visible = false


func hide_event():
	event_marker.visible = false


func mark_route_target():
	$TextureButton.modulate = Color.crimson
