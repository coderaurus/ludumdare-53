extends Node2D

class_name Quest

var quest_name = "Quest"
var active = false
var used_days = 0
var asked_days = 5
# settlements
var from
var to
# unit preferences
var unit = null
var preferred_type = 0
var disliked_type = 0
# delivering
enum GOODS {FOOD, ART, MATERIALS, JEWELRY}
var goods_type = GOODS.FOOD
var goods_type_name = ["FOOD", "ART", "MATERIALS", "JEWELRY"]
# rewarding
var reward = 25

func get_description():
	var text = "\"" 
	text += " I need to get this %s to %s in %s days. You up for it for %s gold?" % \
			[goods_type_name[goods_type], to.settlement_name, asked_days, reward]
	text += "\""
	return text
