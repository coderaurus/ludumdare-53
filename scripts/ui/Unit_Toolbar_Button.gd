extends Control

class_name Unit_Toolbar_Button

var unit



func init(unit: Unit):
	$Profile.texture_normal = unit.portrait
	$Profile.modulate = Color.white
	
	if not unit.hired:
		if !unit.is_hirable():
			$Profile.modulate = Color.gray
		else:
			$Profile.modulate = Color.white


func hide_status():
	$Status.visible = false
	$Status.text = ""


func show_availability():
	if unit.quest == null:
		$Status.text = "Free"
		$Profile.disabled = false
	else:
		$Status.text = "Busy"
		$Profile.disabled = true

	$Status.visible = true


func _on_select():
	if System.game.UI.selecting_quest:
		System.game.UI.select_unit(unit)
	else:
		System.game.UI.open_unit(unit)
