extends Robot

@onready var timer: Timer = $Timer as Timer

var rotacionando: bool = false
var angleAux : float = 360.0

func _ready():
	super._ready()
	timer.start()
	setter()


func move(_delta):
	if !rotacionando:
		myFirstRobot()
	tiro.position = GL.moveTiro(angle)
	attAngle()		

func setter():
	match directionInicial:
		1:
			angle = 270
		2:
			angle = 0
		3:
			angle = 90
		4:
			angle = 180
	tiro.position = GL.moveTiro(angle)
	attAngle()

func rotacionar():
	var tween = get_tree().create_tween()
	await tween.tween_property(self,"angle",angle+360,1).finished
	rotacionando = false
	timer.start()
	
func myFirstRobot():
	match directionInicial:
		1:
			velocity = transform.y * -speed
			
		2:
			velocity = transform.x * speed
			
		3:
			velocity = transform.y * speed
			
		4:
			velocity = transform.x * -speed
	
	move_and_slide()
	
	
func attAngle():
	var aux = GL.getAngleEnemy(enemy,self,angle)
	if aux < 0:
		aux = 360 + aux
	var rot : float = rotation_degrees
	if rot < 0:
		rot = 360 + rot
	var aux2 : float = angle + rot
	if aux2 >= 360.0:
		aux2 = fmod(aux2,360.0)
	if abs(aux - aux2) < 5:
		tiro.atirar(aux,self)	

func _on_timer_timeout():
	velocity = Vector2.ZERO
	speed = -speed
	rotacionando = true
	rotacionar()


func _on_hurtbox_receive_damage(area: Hitbox):
	var x = area.rotation_degrees
	if x < 0:
		x = 360 + x
	rotation = deg_to_rad(x+90)
