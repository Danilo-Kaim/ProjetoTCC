extends Node2D


@export var tiroCena: PackedScene
@onready var tiroDelay = $TiroDelay as Timer
var podeAtirar = true
		
func atirar(rot,par):
	if podeAtirar:
		var tiro = tiroCena.instantiate()
		get_tree().root.call_deferred("add_child",tiro)
		tiro.setPos(global_position)
		tiro.setRotation(rot)
		tiro.setParent(par)
		cooldown()
		tiroDelay.start()
	
func cooldown():
	podeAtirar = false
func _on_tiro_delay_timeout():
	podeAtirar = true
