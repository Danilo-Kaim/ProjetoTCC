extends Robot

@onready var bateuParede: RayCast2D = $BateuParede as RayCast2D

var  input_vector: Vector2 = Vector2.ZERO
var angleAux: float = 0 
var rotacionando: bool = false
var primeiraRot: bool = true

func _ready():
	super._ready()
	match directionInicial:
		1:
			bateuParede.target_position = Vector2(0,-20)
			bateuParede.position = Vector2(0,-40)
			input_vector = Vector2.UP
			angle = 270
		2:
			bateuParede.target_position = Vector2(20,0)
			bateuParede.position = Vector2(40,0)
			input_vector = Vector2.RIGHT
			angle = 0
		3:
			bateuParede.target_position = Vector2(0,20)
			bateuParede.position = Vector2(0,40)
			input_vector = Vector2.DOWN
			angle = 90
		4:
			bateuParede.target_position = Vector2(-20,0)
			bateuParede.position = Vector2(-40,0)
			input_vector = Vector2.LEFT	
			angle = 180
	tiro.position = GL.moveTiro(angle)

func move(_delta):
	if angle < 0:
		angle = 360 - angle
	if rotacionando and angle != angleAux:
		input_vector = Vector2.ZERO
		rotacionar()
	if angle == angleAux:
		rotacionando = false
		setter()
	goWall()
	attAngle()
	velocity =  speed * input_vector 
	move_and_slide()
	
func rotacionar():
	angle -= 1
	tiro.position = GL.moveTiro(angle)

func setter():
	match directionInicial:
		1:
			bateuParede.target_position = Vector2(0,-20)
			bateuParede.position = Vector2(0,-40)
			input_vector = Vector2.UP
		2:
			bateuParede.target_position = Vector2(20,0)
			bateuParede.position = Vector2(40,0)
			input_vector = Vector2.RIGHT
		3:
			bateuParede.target_position = Vector2(0,20)
			bateuParede.position = Vector2(0,40)
			input_vector = Vector2.DOWN
		4:
			bateuParede.target_position = Vector2(-20,0)
			bateuParede.position = Vector2(-40,0)
			input_vector = Vector2.LEFT	
	bateuParede.enabled = true

func goWall():
	if bateuParede.is_colliding():
		directionInicial -= 1
		if directionInicial == 0:
			directionInicial = 4
		bateuParede.enabled = false
		if primeiraRot:
			angleAux = angle - 180
			primeiraRot = false
			if angleAux < 0:
				angleAux = 180 
		else:	
			angleAux = angle - 90
		if angleAux < 0:
			angleAux = 270
		rotacionando = true				
 
func attAngle():
	var aux = GL.getAngleEnemy(enemy,self,angle)
	if aux < 0:
		aux = 360 + aux
	if abs(aux - angle) < 2:
		tiro.atirar(angle,self)	
