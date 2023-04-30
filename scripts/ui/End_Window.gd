extends Panel

class_name End_Window

onready var debrief = $Text
onready var results = $"Game Results"

var company

func open(comp: Company):
	company = comp
	fill_debrief()
	fill_results()
	
	get_parent().visible = true

func _resume_play():
	print("Resuming play")
	get_parent().visible = false
	System.game.continue_playing()


func fill_debrief():
	var tmp = debrief.text
	tmp = tmp.replacen("#company", company.company_name)
	debrief.text = tmp


func fill_results():
	var tmp = results.text
	tmp = tmp.replacen("#days", company.active_days)
	tmp = tmp.replacen("#gold", company.gold)
	results.text = tmp
