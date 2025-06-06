extends Node2D


@export var tiroCena: PackedScene
@onready var tiroDelay: Timer = $TiroDelay as Timer

var podeAtirar: bool = true
		
func atirar(rot: float,par: Robot):
	if podeAtirar:
		var tiro = tiroCena.instantiate()
		get_tree().root.call_deferred("add_child",tiro)
		tiro.position = global_position
		tiro.rotation = deg_to_rad(rot)
		tiro.setParent(par)
		cooldown()
		tiroDelay.start()
	
func cooldown():
	podeAtirar = false
	
func _on_tiro_delay_timeout():
	podeAtirar = true
