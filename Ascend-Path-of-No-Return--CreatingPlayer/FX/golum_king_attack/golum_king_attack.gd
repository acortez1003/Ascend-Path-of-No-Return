extends AnimatedSprite2D

var rock = preload("res://FX/golum_king_attack/golum_king_rocks.tscn")

@onready var timer : Timer = $remove_timer
@onready var muzzle : Marker2D = $Muzzle

var player : CharacterBody2D

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	play("portal_open")
	timer.start()

func _process(_delta):
	if animation == "portal_open" and frame == 4:
		play("idle")
		var rock_instance = rock.instantiate() as Node2D
		rock_instance.global_position = muzzle.global_position
		get_parent().add_child(rock_instance)
		
	
	if timer.is_stopped():
		play("portal_close")
		if frame == 4:
			queue_free()

func _on_remove_timer_timeout():
	timer.stop()
