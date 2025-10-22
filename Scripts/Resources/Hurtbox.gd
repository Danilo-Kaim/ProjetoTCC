extends Area2D
class_name Hurtbox

signal ReceiveDamage

@onready var healthComponent = $"../HealthComponent"

func _on_area_entered(area: Area2D):
	if area is Hitbox and area.getParent() != get_parent():
		healthComponent.tomarDano(area.getDano())
		ReceiveDamage.emit(area)
