extends BossState
class_name Idle

@export var tempoParado: int = 3

func Enter():
	await get_tree().create_timer(3).timeout
	Transitioned.emit(self,nextState)
	
