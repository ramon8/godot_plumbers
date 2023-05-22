extends Area2D

@export var next_level: int

func _on_body_entered(body):
	if body.name.contains("Character"):
		var nextLevel = load("res://Scenes/Levels/level_"+ str(next_level) +".tscn").instantiate()
		get_node("/root/Main/Levels/").add_child(nextLevel)
		get_node("/root/Main/Levels/" + get_parent().name).free()


func _process(delta):
	var click = Input.is_action_just_pressed("click")
	if click:
		var nextLevel = load("res://Scenes/Levels/level_"+ str(next_level) +".tscn").instantiate()
		get_node("/root/Main/Levels/").add_child(nextLevel)
		get_node("/root/Main/Levels/" + get_parent().name).free()
