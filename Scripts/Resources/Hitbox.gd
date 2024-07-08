extends Area2D

@export var corpo : CharacterBody2D
var parent
var dano
func _ready():
	parent = corpo
	dano = corpo.getDano()

func getDano():
	return dano

func getParent():
	return parent			
