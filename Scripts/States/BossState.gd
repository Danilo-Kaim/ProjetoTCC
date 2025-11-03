extends State
class_name BossState


var wander_time: float
var boss: Boss2

func _ready():
	boss = get_parent().get_parent()


