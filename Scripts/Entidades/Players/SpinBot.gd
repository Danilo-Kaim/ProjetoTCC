extends Robot

@export var raio: int  = 100

var center: Vector2 = Vector2(0,0)
var anglePlayer: float = 0

func _ready():
	super._ready()
	center = Vector2(global_position.x-100,global_position.y)

func move(_delta):
	if angle >= 360:
		angle = angle - 360
	Spin()
	tiro.position = GL.moveTiro(angle)
	attAngle()
	
	
func Spin():
	angle += 1.5
	global_position.x = center.x + raio * cos(deg_to_rad(angle)) 
	global_position.y = center.y + raio * sin(deg_to_rad(angle))

func attAngle():
	var aux = GL.getAngleEnemy(enemy,self,angle)
	if aux < 0:
		aux = 360 + aux
	if abs(aux - angle) < 2:
		tiro.atirar(aux,self)




