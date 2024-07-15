extends Node

@export var final : PackedScene


func _on_boss_tutorial_morreu():
	get_tree().reload_current_scene()


func _on_crazy_morreu():
	get_tree().change_scene_to_packed(final)


func _on_wall_morreu():
	get_tree().change_scene_to_packed(final)


func _on_tracker_morreu():
	get_tree().change_scene_to_packed(final)


func _on_track_fire_morreu():
	get_tree().change_scene_to_packed(final)


func _on_myfist_robot_morreu():
	get_tree().reload_current_scene()


func _on_spin_bot_morreu():
	get_tree().reload_current_scene()
