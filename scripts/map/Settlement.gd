extends Node

class_name Settlement

signal on_enter

export var settlement_name := "Town"
export var contact_name := "John"
export var contact_profile : Resource = null

var visited = false
var unlock_tier = 0 # affects the initial arrival event

var ocurring_events = []
var event 




func on_enter():
	_on_enter()

func _on_enter():
	print("Entering %s" % settlement_name)
	if event != null:
		System.game.UI.open_settlement(self, event)
	else:
		System.game.UI.open_settlement(self)
	pass # Replace with function body.
