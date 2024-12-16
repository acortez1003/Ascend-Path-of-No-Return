extends AnimatedSprite2D

var impact_ef = preload("res://FX/laser/laser_impact_effect.tscn")

@export var speed : int
@export var damage : int

var direction : int

func _physics_process(delta):
	move_local_x(direction * speed * delta)

func _on_remove_timer_timeout():
	queue_free()
	
func impact():
	var impact_instance = impact_ef.instantiate() as Node2D
	impact_instance.global_position = global_position
	get_parent().add_child(impact_instance)
	queue_free()

func _on_hitbox_body_entered(body):
	impact()

func _on_hitbox_area_entered(area):
	impact()

func get_damage() -> int:
	return damage
	
func can_damage() -> bool:
	return true
