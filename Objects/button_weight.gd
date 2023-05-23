extends StaticBody2D

@export var weight: int;
@export var is_open: bool;

var current_weight = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_open:
		$Weight.set_text(str(weight - current_weight))
	if weight - current_weight <= 0:
		$Sprite2D/AnimationPlayer.play("closed")
		is_open = true

func _on_area_counter_body_entered(body):
	current_weight += 1


func _on_area_counter_body_exited(body):
	current_weight -= 1
