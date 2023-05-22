extends StaticBody2D

@export var distance: int = -750;

func _on_area_2d_body_entered(body: CharacterBody2D):
	if body.name.contains("Character"):
		var velocity = body.velocity;
		body.set_velocity(Vector2(velocity.x, distance))
