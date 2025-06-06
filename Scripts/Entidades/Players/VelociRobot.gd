extends Robot

var tick : int = 0
var spdOption: bool = true
var spd : float
var speed2 : float

func _ready():
	super._ready()
	speed2 = -(speed + (speed/2))
	setter()


func move(_delta):
	if tick % 64 == 0:
		if spdOption:
			spd = speed
			spdOption = false
		else:
			spd = speed2
			spdOption = true
	rotacionar()
	velociRobot()
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
	await tween.tween_property(self,"angle",angle+15,0.1).finished
	tick += 1
func velociRobot():
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
		tiro.atirar(aux2,self)	


func _on_hurtbox_body_entered(body):
	if body.is_in_group("Fundo"):
		spd = -spd


func _on_hurtbox_receive_damage(area: Hitbox):
	var x = area.rotation_degrees
	if x < 0:
		x = 360 + x
	rotation = deg_to_rad(x+5)
