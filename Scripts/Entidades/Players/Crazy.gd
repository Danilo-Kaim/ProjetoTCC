extends Robot

@onready var collision: CollisionShape2D = $Collision as CollisionShape2D
@onready var texture: Sprite2D = $Texture as Sprite2D
@onready var hurtbox: Area2D = $Hurtbox as Area2D
@onready var bateuParede: Area2D = $BateuParede as Area2D

func _ready():
	super._ready()
	turn()

func move(_delta):
	crazy()
	move_and_slide()

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
	repairRotation(rotation)
	
	
func crazy():	
	attAngle()
	match directionInicial:
		1:
			velocity = transform.y * -speed
			
		2:
			velocity = transform.x * speed
			
		3:
			velocity = transform.y * speed
			
		4:
			velocity = transform.x * -speed	
	repairRotation(rotation)

func turn():
	var tween = get_tree().create_tween()
	angle = rotation
	angle -= deg_to_rad(90)
	tween.tween_property(self,"rotation",angle,1.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)
	angle += deg_to_rad(180)
	tween.tween_property(self,"rotation",angle,1.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)
	angle -= deg_to_rad(180)
	tween.tween_property(self,"rotation",angle,1.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)
	
func repairRotation(rot):			
	collision.rotation = -rot
	texture.rotation = -rot
	tiro.rotation = -rot
	hurtbox.rotation = -rot
	bateuParede.rotation = -rot
 
func attAngle():
	var aux1 = GL.getAngleEnemy(enemy,self,angle)
	if aux1 < 0:
		aux1 = 360 + aux1		
	var aux2 = rotation_degrees
	if aux2 < 0:
		aux2 = 360 + aux2
	if abs(aux1 - aux2) < 3:
		tiro.atirar(aux2,self)

func _on_bateu_parede_body_entered(_body):
	speed *= -1


func _on_resete_tween_timeout():
	turn()
