extends State
class_name BossState


var wander_time: float
var boss: Boss1

func _ready():
	boss = get_parent().get_parent()


