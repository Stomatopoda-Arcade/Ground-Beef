extends Area2D

enum BEAM_TYPE {OFF,TRACTOR,DEATH}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_beam(type): 
	if type == BEAM_TYPE.TRACTOR:
		$TractorBeam.visible = true
		$DeathBeam.visible = false
		$CollisionShape2D.disabled = false
	elif type == BEAM_TYPE.DEATH:
		$DeathBeam.visible = true
		$TractorBeam.visible = false
		$CollisionShape2D.disabled = false
	elif type == BEAM_TYPE.OFF:
		$DeathBeam.visible = false
		$TractorBeam.visible = false
		$CollisionShape2D.disabled = true
