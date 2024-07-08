extends Node

@export var final : PackedScene

func _on_crazy_morreu():
	get_tree().change_scene_to_packed(final)


func _on_corners_morreu():
	get_tree().change_scene_to_packed(final)
