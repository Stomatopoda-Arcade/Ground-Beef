extends StaticBody2D

class_name Cow

var cow_flipped = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	cow_flipped = !cow_flipped
	$Sprite2D.flip_h = cow_flipped
	pass # Replace with function body.
