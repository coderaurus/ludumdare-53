extends Node2D
class_name QuestManager


onready var quest_scene : PackedScene = preload("res://scenes/quest/Quest.tscn")

var quests = get_children()


func generate_first_quest():
	var quest = quest_scene.instance()
	quest.quest_name = "First Task"
	quest.from = System.game.map.get_settlement(6)
	quest.from.add_quest(quest)
	quest.to = System.game.map.get_settlement(1)
	
	quest.asked_days = int(rand_range(10, 20))
	quest.goods_type = int(rand_range(0, quest.GOODS.size()))
	quest.goods_type_name[quest.goods_type]
	
	match(quest.goods_type):
		quest.GOODS.ART:
			quest.reward = int(rand_range(30, 50))
		quest.GOODS.FOOD:
			quest.reward = int(rand_range(10, 15))
		quest.GOODS.JEWELRY:
			quest.reward = int(rand_range(60, 100))
		quest.GOODS.MATERIALS:
			quest.reward = int(rand_range(25, 75))
	
	add_child(quest)
	return quest


func generate_quest():
	var quest = quest_scene.instance()
	quest.quest_name = "New Task"
	
	quest.quest_name = "First Task"
	quest.from = System.game.map.get_random_settlement()
	quest.from.add_quest(quest)
	quest.to = System.game.map.get_random_settlement(quest.from)
	
	quest.asked_days = int(rand_range(4, 12))
	quest.goods_type = int(rand_range(0, quest.GOODS.size()))
	quest.goods_type_name[quest.goods_type]
	
	match(quest.goods_type):
		quest.GOODS.ART:
			quest.reward = int(rand_range(25, 50))
		quest.GOODS.FOOD:
			quest.reward = int(rand_range(5, 15))
		quest.GOODS.JEWELRY:
			quest.reward = int(rand_range(50, 100))
		quest.GOODS.MATERIALS:
			quest.reward = int(rand_range(15, 75))
	
	quest.from.add_quest(quest)
	quests.append(quest)
	add_child(quest)
	return quest


func add_day():
	for q in get_children():
		if q.active:
			q.used_days += 1
