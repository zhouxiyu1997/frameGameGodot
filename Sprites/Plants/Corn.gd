extends Area2D

@onready var timer = $Timer
var time = 0.0
@onready var plant = $Sprite2D
var stage = 1
var PlantNum = -1

func _ready():
	if time != 0:
		timer.wait_time = time
	if PlantNum == -1:
		PlantNum = Game.Plot.size()
	Game.Plot += [{
		"Seed": "Corn",
		"TimeLeft": timer.time_left,
		"Stage": stage,
		"Harvested": false,
	}]
	

func _process(delta):
	Game.Plot[PlantNum]["TimeLeft"] = timer.time_left
	match stage:
		1:
			plant.frame = stage
		2:
			plant.frame = stage
		3:
			plant.frame = stage
		4:
			plant.frame = stage
		5:
			plant.frame = stage
		6:
			plant.frame = 5
	Utils.save_game()
func _on_Timer_timeout():
	if stage <= 5:
		stage += 1
	Game.Plot[PlantNum]["Stage"] = stage
	Utils.save_game()


func _on_Corn_body_entered(body):
	var has_item = false
	if stage >= 5:
		if body.name == "Player":
			for i in Game.Harvests.size():
				if "Corn" in Game.Harvests[i]["Name"]:
					has_item = true
				
			if has_item:
				for i in Game.Harvests.size():
					if "Corn" == Game.Harvests[i]["Name"]:
						Game.Harvests[i]["Count"] += 1
			else:
				Game.Harvests += [{
					"Name": "Corn",
					"Count": 1,
					"Consumable": true,
				}]
			Game.Plot[PlantNum]["Harvested"] = true
			get_parent().has_seed = false
			queue_free()
			Utils.save_game()
