extends Weapon

export var fire_range = 10




func _ready():
	raycast.cast_to = Vector3(0, 2, -fire_range)
	pass 

