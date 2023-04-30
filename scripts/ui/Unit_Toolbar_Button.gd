extends Control

class_name Unit_Toolbar_Button

var unit



func init(u: Unit):
	if u != unit:
		unit = u
	$Profile.disabled = false
	$Profile.texture_normal = u.portrait
	$Profile.modulate = Color.white
	$Status.text = ""
	
	if not u.hired:
		if !u.is_hirable():
			$Profile.modulate = Color(0.2, 0.2, 0.2)
		else:
			$Profile.modulate = Color.white


func hide_status():
	$Status.visible = false
	$Status.text = ""


func show_availability():
	if unit.quest == null and unit.hired:
		$Status.text = "Free"
		$Profile.disabled = false
	elif !unit.hired:
		$Status.text = ""
		$Profile.disabled = true
	else:
		$Status.text = "Busy"
		$Profile.disabled = true

	$Status.visible = true


func _on_select():
	if System.game.UI.selecting_quest:
		System.game.UI.select_unit(unit)
	else:
		System.game.UI.open_unit(unit)
		disable()


func clear():
	init(unit)
	

func disable():
	$Profile.disabled = true
