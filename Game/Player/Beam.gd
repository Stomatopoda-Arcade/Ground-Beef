extends Area2D

enum BEAM_TYPE {OFF,TRACTOR,DEATH}

var beam_locked = false
var active_beam = BEAM_TYPE.OFF

signal object_abducted(groups)
signal object_destroyed(groups)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_beam(type): 
	if !beam_locked:
		if type == BEAM_TYPE.TRACTOR:
			beam_locked = true
			active_beam = BEAM_TYPE.TRACTOR
			$TractorBeam.visible = true
			$DeathBeam.visible = false
			$CollisionShape2D.disabled = false
			$DisplayTimer.start()
		elif type == BEAM_TYPE.DEATH:
			beam_locked = true
			active_beam= BEAM_TYPE.DEATH
			$DeathBeam.visible = true
			$TractorBeam.visible = false
			$CollisionShape2D.disabled = false
			$DisplayTimer.start()
	if type == BEAM_TYPE.OFF:
		active_beam = BEAM_TYPE.OFF
		$DeathBeam.visible = false
		$TractorBeam.visible = false
		$CollisionShape2D.disabled = true

func _on_display_timer_timeout():
	set_beam(BEAM_TYPE.OFF)
	$RechargeTimer.start()

func _on_recharge_timer_timeout():
	beam_locked = false


func _on_body_entered(body):
	if body.is_in_group("abductable") and active_beam == BEAM_TYPE.TRACTOR:
		object_abducted.emit(body.get_groups())
		body.queue_free()
	elif body.is_in_group("destroyable") and  active_beam == BEAM_TYPE.DEATH:
		object_destroyed.emit(body.get_groups())
		body.queue_free()
