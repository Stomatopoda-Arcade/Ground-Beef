extends Control


func set_score():
	var cows = 0
	var tanks = 0
	var jets = 0
	for scorable in Global.scored_objects:
		if scorable == "cow":
			cows+=1
		elif scorable == "tank":
			tanks+=1
		elif scorable == "jet":
			jets+=1
	
	$CenterContainer/VBoxContainer/LevelLabel.text = "Level %s Complete"%Global.level
	$CenterContainer/VBoxContainer/AbductedContainer/CowsAbductedContainer/CowsAbductedValue.text = "x%d"%cows
	$CenterContainer/VBoxContainer/DestroyedContainer/TanksDestroyedContainer/TankDestroyedValue.text = "x%d"%tanks
	$CenterContainer/VBoxContainer/DestroyedContainer/JetsDestroyedContainer/JetsDestroyedValue.text = "x%d"%jets
	$CenterContainer/VBoxContainer/TimeContainer/TimeValue.text = str(Global.time_remaining)
	$CenterContainer/VBoxContainer/TotalScoreContainer/ScoreValue.text = str(Global.score)
	
