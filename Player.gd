extends KinematicBody

# Settings
export var speed = 12
export var acceleration = 10
export var gravity = 0.98
export var jump_power = 20
export var mouse_sensitivity = 0.15

onready var head = $Head
onready var camera = $Head/Camera

var velocity = Vector3()
var camera_x_rotation = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("mouse_click"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_action_just_pressed("fullscreen_toggle"):
		OS.window_fullscreen = !OS.window_fullscreen
	
# mouse input stuff
func _input(event):
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		pass
	else:
		if event is InputEventMouseMotion:
			head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
			var x_delta = event.relative.y * mouse_sensitivity
			if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
				camera.rotate_x(deg2rad(-x_delta))
				camera_x_rotation += x_delta
# keyboard input stuff
func _physics_process(delta):
	var head_basis = head.get_global_transform().basis
	
	var direction = Vector3()
	if Input.is_action_pressed("move_forward"):
		direction -= head_basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += head_basis.z
	if Input.is_action_pressed("move_left"):
		direction -= head_basis.x
	if Input.is_action_pressed("move_right"):
		direction += head_basis.x
	if Input.is_action_pressed("reload"):
		# restart player location
		get_tree().reload_current_scene()
		
	direction = direction.normalized()
	
	velocity.y -= gravity
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y += jump_power
	
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	
	velocity = move_and_slide(velocity, Vector3.UP)
