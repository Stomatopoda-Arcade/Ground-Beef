extends Node
const GameResource = preload("res://Game/game.tscn")
var game_started = false
var game_instance = null
var current_title_screen = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	init_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_anything_pressed() and !game_started:
		start_game()
	

func start_game():
	game_started = true
	$TitleSwitchTimer.stop()
	$TitleScreen.visible = false
	$HighScoreScreen.visible = false
	$LevelScreen.visible = false
	$GameOverScreen.visible = false
	game_instance = GameResource.instantiate()
	game_instance.level_complete.connect(_on_level_complete)
	game_instance.game_over.connect(_on_game_over)
	self.add_child(game_instance)
	
func init_game():
	Global.lives = 3
	Global.score = 0
	Global.level = 1
	current_title_screen = 0
	game_started = false
	$TitleScreen.visible = true
	$HighScoreScreen.visible = false
	$LevelScreen.visible = false
	$GameOverScreen.visible = false
	$TitleSwitchTimer.start()

func _on_level_complete():
	game_instance.queue_free()
	Global.score += Global.time_remaining
	$LevelScreen.set_score()
	$LevelScreen.visible = true
	$LevelCompleteTimer.start()
	pass

func _on_game_over():
	game_instance.queue_free()
	$GameOverScreen.visible = true
	$GameOverTimer.start()
	pass


func _on_title_switch_timer_timeout():
	current_title_screen = (current_title_screen + 1)%2
	if current_title_screen == 0:
		$TitleScreen.visible = true
		$HighScoreScreen.visible = false
	elif current_title_screen == 1:
		$TitleScreen.visible = false
		$HighScoreScreen.visible = true


func _on_game_over_timer_timeout():
	$HighScoreScreen.check_high_score()
	init_game()


func _on_level_complete_timer_timeout():
	Global.level += 1
	start_game()
