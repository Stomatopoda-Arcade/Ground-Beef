extends StaticBody2D
enum TANK_FACING {TANK45,TANK90,TANK135}

@export var projectile_velocity = 250 
@export var starting_facing = TANK_FACING.TANK45
@export var starting_difficulty = Global.DIFFICULTY.EASY
var projectile_angle = 315

signal fire_projectile(projectile_angle,projectile_velocity,projectile_position)

# Called when the node enters the scene tree for the first time.
func _ready():
	if starting_facing == TANK_FACING.TANK45:
		$Tank45.visible = true
		$Tank90.visible = false
		projectile_angle = 315
	elif starting_facing == TANK_FACING.TANK90:
		$Tank45.visible = false
		$Tank90.visible = true
		projectile_angle = 270
	elif starting_facing == TANK_FACING.TANK135:
		$Tank45.visible = true
		$Tank90.visible = false
		$Tank45.flip_h = true
		projectile_angle = 225
	
	if starting_difficulty == Global.DIFFICULTY.EASY:
		$Timer.wait_time = 3
	elif starting_difficulty == Global.DIFFICULTY.MEDIUM:
		$Timer.wait_time = 2
	elif starting_difficulty == Global.DIFFICULTY.HARD:
		$Timer.wait_time = 1
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	fire_projectile.emit(projectile_angle,projectile_velocity,position)
	
	
