extends Node
class_name KnifeManager



@export var damageHitbox: int = 5
@export var tiroShootDamage: int = 10

@onready var knife_scene = preload("res://Cenas/Resources/TiroAction.tscn")
var boss: Boss2


func _ready():
	boss = get_parent()

func InvokeKnife():
	var offsets = [
		Vector2(boss.position.x, boss.position.y-50),   # cima
		Vector2(boss.position.x, boss.position.y+50),    # baixo
		Vector2(boss.position.x-50, boss.position.y),   # esquerda
		Vector2(boss.position.x+50, boss.position.y)     # direita
	]
	for offset in offsets:
		var knife = knife_scene.instantiate()
		add_child(knife)
		
		# já nasce na posição final, pequena e sem rotação
		knife.position = offset
		knife.scale = Vector2(0, 0)
		knife.rotation_degrees = 0
		knife.hitbox_faca.parent = get_parent()
		knife.hitbox_faca.damage = damageHitbox
		
		# cria o tween
		var tween = create_tween()
		
		# animações com easing suave
		var grow = tween.tween_property(knife, "scale", Vector2(1, 1), 4.0)
		grow.set_trans(Tween.TRANS_SINE)
		grow.set_ease(Tween.EASE_OUT)
		
		# faz girar junto com o crescimento (em paralelo)
		var rotate = tween.parallel().tween_property(knife, "rotation_degrees", 1440.0, 4.0)
		rotate.set_trans(Tween.TRANS_LINEAR)




