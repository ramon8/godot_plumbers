extends Node2D

var simultaneous_scene = preload("res://Scenes/level_selector.tscn").instantiate()


func _on_play_pressed():
	get_node("/root/Main/Levels").add_child(simultaneous_scene)
	get_node("/root/Main/Levels/menu").queue_free()


func _on_exit_pressed():

	get_tree().quit()
