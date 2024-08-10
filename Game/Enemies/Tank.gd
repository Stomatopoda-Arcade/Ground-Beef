extends StaticBody2D
const ProjectileResource = preload("res://Game/Enemies/projectile.tscn")
enum TANK_FACING {TANK45,TANK90,TANK135}
enum DIFFICULTY {EASY,MEDIUM,HARD}

@export var projectile_velocity = 250 
@export var starting_facing = TANK_FACING.TANK45
@export var starting_difficulty = DIFFICULTY.EASY
var projectile_angle = 315

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
	
	if starting_difficulty == DIFFICULTY.EASY:
		$Timer.wait_time = 3
	elif starting_difficulty == DIFFICULTY.MEDIUM:
		$Timer.wait_time = 2
	elif starting_difficulty == DIFFICULTY.HARD:
		$Timer.wait_time = 1
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var projectile_instance = ProjectileResource.instantiate()
	projectile_instance.projectile_velocity = projectile_velocity
	projectile_instance.angle = projectile_angle
	self.add_child(projectile_instance)
	self.move_child(projectile_instance,0)
	
