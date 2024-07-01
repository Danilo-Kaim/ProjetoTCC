extends CharacterBody2D

@export var speed: int = 300
@export var hp: int = 10
@onready var tiro = $TiroPos as Marker2D
var  input_vector = Vector2.ZERO
var angle = 0


func _physics_process(_delta):
	controle()
	attAngle()
	velocity =  speed * input_vector.normalized() 
	move_and_slide()
	
func controle():
	input_vector.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input_vector.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")	 
	if Input.is_action_just_pressed("Atirar"):
		tiro.atirar(angle,self)
		
func moveTiro():
	var raio = 50
	tiro.position.x = raio * cos(deg_to_rad(angle)) 
	tiro.position.y = raio * sin(deg_to_rad(angle)) 

func getAngleMouse() -> float:
	var directionMouse = get_global_mouse_position() - position
	var bearingRadians = atan2(directionMouse.y,directionMouse.x)

	return bearingRadians

func attAngle():
	var absoluteBearing = deg_to_rad(angle) + getAngleMouse()
	var gunTurnAngle = rad_to_deg(absoluteBearing) - angle
	angle = gunTurnAngle
	moveTiro()


func _on_hurtbox_area_entered(area):
	if area.has_method("getParent"):
		if area.getParent() != self:
			print("Player Tomou Dano")









