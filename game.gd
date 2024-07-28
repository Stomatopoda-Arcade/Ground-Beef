extends Node2D



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
	
func handle_destroyed(groups):
	print(groups)
