extends Hitbox

@onready var collision: CollisionShape2D = $Collision as CollisionShape2D

var timer: Timer

func _ready():
	super._ready()
	timer = GL.createTimer(0.5,true,false)
	timer.connect("timeout",_on_timer_timeout)

func _on_area_entered(area):
	collision.call_deferred("set_disabled", true)
	timer.start()
	
func _on_timer_timeout():
	collision.call_deferred("set_disabled", false)
