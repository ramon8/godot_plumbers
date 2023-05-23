extends StaticBody2D

@export var is_open: bool;

func _on_area_counter_body_entered(body):
	$Sprite2D/AnimationPlayer.play("closed")
	is_open = true

