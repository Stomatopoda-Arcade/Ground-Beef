extends Node2D


var score = 0
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
