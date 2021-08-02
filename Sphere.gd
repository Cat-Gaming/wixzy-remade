extends KinematicBody

export var acceleration = 10

var velocity = Vector3()



func _ready():
	pass 

func _physics_process(delta):
	
	
	velocity = move_and_slide(velocity)
