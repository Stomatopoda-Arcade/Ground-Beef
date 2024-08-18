extends Control

func _ready():
	set_high_score()

func set_high_score():
	var initial_nodes = $VBoxContainer/HighScoresContainer/Initials.get_children()
	var score_nodes = $VBoxContainer/HighScoresContainer/Score.get_children()
	var i = 0
	for high_score in Global.high_scores:
		initial_nodes[i].text = high_score.initial
		score_nodes[i].text = str(high_score.score)
		i+=1
	
func check_high_score():
	Global.high_scores.append({"initial": "NEW", "score": Global.score})
	Global.high_scores.sort_custom(func(a, b): return a["score"] >= b["score"])
	Global.high_scores.pop_back()
	set_high_score()
