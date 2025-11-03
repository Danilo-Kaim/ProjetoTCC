extends Area2D
class_name Hitbox

var damage: int = 0

var parent: Node2D


func _ready():
	parent = get_parent()
	damage = parent.damageHitbox
			
