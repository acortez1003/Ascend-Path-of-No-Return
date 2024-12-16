extends AnimatedSprite2D

@export var speed : int
@export var damage : int

var travel_played : bool = false

func _physics_process(delta):
	if !travel_played:
		play("travel")
		travel_played = true
		
	if animation != 'impact':
		move_local_y(speed * delta)
		
	if animation == 'impact' and frame == 4:
		queue_free()

func _on_remove_timer_timeout():
	queue_free()
	
func impact():
	play("impact")

func _on_hitbox_body_entered(_body):
	impact()

func _on_hitbox_area_entered(_area):
	impact()

func get_damage() -> int:
	return damage
	
func can_damage() -> bool:
	if animation == "impact" and frame == 4:
		return true
	else:
		return false
