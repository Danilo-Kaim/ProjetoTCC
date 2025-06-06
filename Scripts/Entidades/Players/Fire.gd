extends Robot

@onready var timer: Timer = $Timer as Timer

var up: bool = true
var loked: bool = false

func _ready():
	super._ready()
	setter()

func move(_delta):
	if !loked:
		angle += 1.6
		if angle >= 360:
			angle = angle - 360
		tiro.position = GL.moveTiro(angle)		
	attAngle()

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
	
func fire(rot):
	speed = 8000
	rotation = deg_to_rad(rot)
	if up:
		velocity = transform.x  * speed
	else:
		velocity = transform.x  * -speed	
	timer.start()
	move_and_slide()
 
func attAngle():
	var aux = GL.getAngleEnemy(enemy,self,angle)
	if aux < 0:
		aux = 360 + aux
	if abs(aux - angle) < 2:
		loked = true
		angle = aux
		tiro.position = GL.moveTiro(angle)
		tiro.atirar(angle,self)
	else:
		loked = false	


func _on_timer_timeout():
	if up:
		up = false
	else:
		up = true	
	rotation_degrees = 0
	speed = 0

func _on_hurtbox_receive_damage(area: Hitbox):
	var x = area.rotation_degrees
	if x < 0:
		x = 360 + x
	fire(x+90)
