extends Weapon

export var weapon_range = 30

func _ready():
	raycast.cast_to(Vector3(0, 0, -weapon_range))
	pass
