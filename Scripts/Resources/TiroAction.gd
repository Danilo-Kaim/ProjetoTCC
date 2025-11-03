extends Node2D
class_name Tiro

@export var damageHitbox: int = 10
@export var tiroShootDamage: int = 10
@export var tiroCena: PackedScene
@export var tiroCooldown: float = 0.5
@onready var tiroDelay: Timer = $TiroDelay as Timer
@onready var hitbox_faca: Hitbox = $HitboxFaca

var podeAtirar: bool = true

func _ready():
	tiroDelay.wait_time = tiroCooldown
	hitbox_faca.parent = get_parent()
		
func atirar(rot: float,par: CharacterBody2D):
	if podeAtirar:
		var tiro = tiroCena.instantiate()
		get_tree().current_scene.call_deferred("add_child", tiro)
		tiro.position = global_position
		tiro.rotation = deg_to_rad(rot)
		tiro.parent = par
		cooldown()
		tiroDelay.start()
		
func multiTiro(arrayRot: Array,par: CharacterBody2D):
	if podeAtirar:
		for rot in arrayRot:
			var tiro = tiroCena.instantiate()
			get_tree().current_scene.call_deferred("add_child", tiro)
			tiro.position = global_position
			tiro.rotation = deg_to_rad(rot)
			tiro.setParent(par)
			tiro.damage = tiroShootDamage
		cooldown()
		tiroDelay.start()


func cooldown():
	podeAtirar = false
	
func _on_tiro_delay_timeout():
	podeAtirar = true
