extends Node2D


var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerCharacter/Beam.object_abducted.connect(handle_abducted)
	$PlayerCharacter/Beam.object_destroyed.connect(handle_destroyed)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
func handle_abducted(groups):
	print(groups)
	score = score + 1
	$PlayerCharacter.set_score(score)
	
func handle_destroyed(groups):
	print(groups)
