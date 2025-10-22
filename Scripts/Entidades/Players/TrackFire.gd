extends Robot

func _ready():
	super._ready()
	setter()


func setter():
	match directionInicial:
		1:
			angle = -90
		2:
			angle = 0
		3:
			angle = 90
		4:
			angle = 180
	tiro.position = GL.moveTiro(angle)


func _on_timer_timeout():
	angle = GL.getAngleEnemy(enemy,self,angle)
	tiro.position = GL.moveTiro(angle)
	tiro.atirar(angle,self)
