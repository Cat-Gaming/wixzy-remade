extends Node

class_name Weapon

export var fire_rate = 0.5
export var clip_size  = 5
export var reload_rate = 1

var current_ammo = clip_size
var can_fire = true
var reloading = false

onready var sound = $"/root/World/Player/audio_player"
onready var ammo_label = $"/root/World/ui/Label"
onready var raycast = $"../Head/Camera/RayCast"
onready var rickroll = $"/root/World/Player/rickroll_player"
onready var minecraft = $"/root/World/Player/minecraft_player"

func _ready():
	current_ammo = clip_size
	pass 

func _process(delta):
	if reloading:
		ammo_label.set_text("Reloading...")
	else:
		ammo_label.set_text("%d / %d" % [current_ammo, clip_size])
	if Input.is_action_just_pressed("mouse_click") and can_fire:
		if current_ammo > 0 and not reloading:
			print("Fired Weapon!")
			can_fire = false
			current_ammo -= 1
			check_collision()
			yield(get_tree().create_timer(fire_rate), "timeout")
			can_fire = true
		elif not reloading:
			reloading = true
			print("Reloading!")
			yield(get_tree().create_timer(fire_rate), "timeout")
			current_ammo = clip_size
			print("Reload Complete!")
			reloading = false
func check_collision():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("Enemy"):
			collider.queue_free()
			print("Killed " + collider.name)
			sound.play()
		elif collider.is_in_group("Spoon"):
			collider.queue_free()
			print("You Have Collected The Spoon!")
			sound.play()
		elif collider.is_in_group("RickRoll"):
			print("You have Been Rickrolled!")
			rickroll.play()
		elif collider.is_in_group("minecraft"):
			print("You have Been Minerolled!")
			minecraft.play()
			
