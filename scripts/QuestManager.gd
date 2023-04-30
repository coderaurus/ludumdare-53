extends Node2D
class_name QuestManager


onready var quest_scene : PackedScene = preload("res://scenes/quest/Quest.tscn")

var quests = get_children()


func generate_first_quest():
	var quest = quest_scene.instance()
	quest.quest_name = "First Task"
	quest.from = System.game.map.get_settlement(0)
	quest.to = System.game.map.get_settlement(2)
	
	add_child(quest)
	return quest


func generate_quest():
	var quest = quest_scene.instance()
	quest.quest_name = "New Task"
#	quest.from = get_parent().get_settlement(0)
#	quest.to = get_parent().get_settlement(2)
	
	add_child(quest)
	return quest


func add_day():
	for q in get_children():
		if q.active:
			q.used_days += 1
