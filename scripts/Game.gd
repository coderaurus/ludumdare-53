extends Node
class_name Game

export var in_menu = false
onready var UI = $UI
onready var map = $Map

# Called when the node enters the scene tree for the first time.
func _ready():
	System.game = self
