extends Robot

@onready var timer: Timer = $Timer as Timer

var tween : Tween

func _ready():
	super._ready()
	setter()
	rotacionar()


func move(_delta):
	attAngle()

func setter():
	match directionInicial:
		1:
			rotation = deg_to_rad(270)
		2:
			rotation = deg_to_rad(0)
		3:
			rotation = deg_to_rad(90)
		4:
			rotation = deg_to_rad(180)
			
func Tracker(spd):	
	match directionInicial:
		1:
			velocity = transform.y * -spd
			
		2:
			velocity = transform.x * spd
			
		3:
			velocity = transform.y * spd
			
		4:
			velocity = transform.x * -spd	
	move_and_slide()
	

func rotacionar():
	tween = get_tree().create_tween()
	tween.tween_property(self,"rotation",rotation+deg_to_rad(360),1.5)
	tween.finished.connect(_on_tween_finished)
 
func attAngle():
	var aux2 = rotation_degrees
	if aux2 >= 360:
		aux2 = fmod(aux2,360.0)		
	var aux = GL.getAngleEnemy(enemy,self,angle)
	if aux < 0:
		aux = 360 + aux
	if abs(aux - aux2) < 3:
		tween.pause()
		timer.start()
	if !tween.is_running():
		if GL.calcDistance(enemy,self) < 180:
			Tracker(-speed)
		elif GL.calcDistance(enemy,self) < 250:
			tiro.atirar(aux2,self)	
		else:		
			Tracker(speed)				

func _on_tween_finished():
	tween.stop()
	rotacionar()

func _on_timer_timeout():
	velocity = Vector2.ZERO
	tween.play()
	
