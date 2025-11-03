extends Area2D
class_name Hurtbox

signal ReceiveDamage

@onready var healthComponent = $"../HealthComponent"

func _on_area_entered(area: Area2D):
	if area is Hitbox and area.parent != get_parent():
		healthComponent.tomarDano(area.damage)
		ReceiveDamage.emit(area)
