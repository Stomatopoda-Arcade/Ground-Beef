extends Node2D

signal game_over(score)
signal level_complete(score, scored_objects)

var score = 0
var lives = 3
var scored_objects = []

@export var level = 1
@export var abducted_score = 100
@export var jet_score = 50
@export var tank_score = 25
@export var time_remaining = 180


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerCharacter/Beam.object_abducted.connect(handle_abducted)
	$PlayerCharacter/Beam.object_destroyed.connect(handle_destroyed)
	$PlayerCharacter.set_timer(time_remaining)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#checking for win condition
	check_for_enemies()
	pass
	

func check_for_enemies():
	var more_enemies = false
	var children = self.get_children()
	
	for child in children:
		# check if any enemies left
		if child.is_in_group("enemy"):
			# if there is at least 1 enemy return
			more_enemies = true
			return
			
	# if no more enemies then level completed
	if !more_enemies:
		level_complete.emit(score)

func handle_abducted(groups):
	if groups.has("cow"):
		score = score + abducted_score
		scored_objects.append("cow")
	$PlayerCharacter.set_score(score)
	
func handle_destroyed(groups):
	if groups.has("cow"):
		score = score - abducted_score
	elif groups.has("tank"):
		score = score + tank_score
		scored_objects.append("tank")
	elif groups.has("jet"):
		score = score + jet_score
		scored_objects.append("jet")
	$PlayerCharacter.set_score(score)


func _on_game_timer_timeout():
	if time_remaining > 0:
		time_remaining -= 1
		$PlayerCharacter.set_timer(time_remaining)
	else:
		level_complete.emit(score)

func _on_screen_wrap_body_exited(body):
	if body.is_in_group("projectile"):
		body.queue_free()
	# only teleport player if they arent disabled
	elif !body.is_in_group("player") or !$PlayerCharacter.player_disabled:
		# get left and right edge of screen wrap collision area
		var left_edge = $ScreenWrap.position.x - ($ScreenWrap/CollisionShape2D.shape.get_rect().size.x/2)
		var right_edge = $ScreenWrap.position.x + ($ScreenWrap/CollisionShape2D.shape.get_rect().size.x/2)
		var buffer = 150
		# teleport player to left or right edge + buffer
		if sign(body.position.x) == -1:
			body.position = Vector2(right_edge-buffer,body.position.y)
		else:
			body.position = Vector2(left_edge+buffer,body.position.y)


func _on_player_character_damaged():
	if !$PlayerCharacter.player_disabled:
		lives -= 1
		$PlayerCharacter.set_lives(lives)
		$PlayerCharacter.disable_player(true)
		$PlayerResetTimer.start()
		$GameTimer.stop()


func _on_player_reset_timer_timeout():
	if lives > 0:
		$PlayerCharacter.position = Vector2(0,0)
		$PlayerCharacter.disable_player(false)
		$GameTimer.start()
	else:
		$GameTimer.stop()
		game_over.emit(score)
