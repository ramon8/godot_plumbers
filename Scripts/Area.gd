extends Area2D

@export var next_level: int

func _on_body_entered(body):
	if body.name.contains("Character"):
		print(get_parent().name)
		var nextLevel = load("res://Scenes/Levels/level_"+ str(next_level) +".tscn").instantiate()
		get_node("/root").add_child(nextLevel)
		get_node("/root/" + get_parent().name).free()
