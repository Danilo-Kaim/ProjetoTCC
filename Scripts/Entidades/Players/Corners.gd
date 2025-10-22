extends Robot

@onready var bateuParede: RayCast2D = $BateuParede as RayCast2D

var  input_vector: Vector2 = Vector2.ZERO
var nCollision: int = 0
var canShoot: bool = false
var canMove: bool = true

func _ready():
	super._ready()
	setter()

func move(_delta):
	if canMove:
		goCorners()
	else:
		input_vector = Vector2.ZERO	
	velocity =  speed * input_vector 
	move_and_slide()

func setter():
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

func goCorners():
	if bateuParede.is_colliding():
		nCollision += 1
	if nCollision == 1:
		directionInicial -= 1
		if directionInicial == 0:
			directionInicial = 4	
		setter()
		nCollision += 1
	if nCollision > 2:
		canShoot = true			
 
func attAngle():
	var aux = GL.getAngleEnemy(enemy,self,angle)
	if aux < 0:
		aux = 360 + aux
	if abs(aux - angle) < 10 and nCollision < 3:
		canMove = false
		canShoot = true
		angle = aux	
	else:
		if nCollision > 2:
			canMove = false
			angle = aux
			tiro.position = GL.moveTiro(angle)		
		else:
			canMove = true
			canShoot = false	

func _on_tempo_tiro_timeout():
	attAngle()
	if canShoot:
		tiro.atirar(angle,self)
	if nCollision < 3:
		setter()	
