extends Area2D
class_name Hitbox

var damage: int

var parent: CharacterBody2D


func _ready():
	parent = get_parent()
	damage = parent.damage

func getDano():
	return damage

func getParent():
	return parent

func setParent(par: CharacterBody2D):
	parent = par			
