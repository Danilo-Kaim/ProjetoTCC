extends BossState
class_name Idle


func Enter():
	await get_tree().create_timer(3).timeout
	Transitioned.emit(self,"MovingAround")
	
