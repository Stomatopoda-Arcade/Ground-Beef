extends Node2D


var score = 0
var lives = 3
var level = 1
var abducted_score = 100
var jet_score = 50
var tank_score = 25

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerCharacter/Beam.object_abducted.connect(handle_abducted)
	$PlayerCharacter/Beam.object_destroyed.connect(handle_destroyed)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func handle_abducted(groups):
	score = score + abducted_score
	$PlayerCharacter.set_score(score)
	
func handle_destroyed(groups):
	if groups.has("cow"):
		score = score - abducted_score
	elif groups.has("tank"):
		score = score + tank_score
	elif groups.has("jet"):
		score = score + jet_score
	$PlayerCharacter.set_score(score)


func _on_player_character_damaged(collider):
	if !$PlayerCharacter.player_disabled:
		lives -= 1
		$PlayerCharacter.set_lives(lives)
		$PlayerCharacter.disable_player(true)
	


func _on_screen_wrap_body_exited(body):
	var left_edge = $ScreenWrap.position.x - ($ScreenWrap/CollisionShape2D.shape.get_rect().size.x/2)
	var right_edge = $ScreenWrap.position.x + ($ScreenWrap/CollisionShape2D.shape.get_rect().size.x/2)
	var buffer = 150
	if sign(body.position.x) == -1:
		body.position = Vector2(right_edge-buffer,body.position.y)
	else:
		body.position = Vector2(left_edge+buffer,body.position.y)
		
		
