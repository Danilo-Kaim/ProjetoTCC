extends NavigationAgent2D

var player

func makePath() -> void:
	target_position = player.global_position
	pass

func setPlayer(jogador):
	player = jogador

func _on_make_path_timeout():
	makePath()
