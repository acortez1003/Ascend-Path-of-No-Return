extends Node

@export var node_finite_state_machine : NodeFiniteStateMachine

func _on_attack_area_body_entered(body):
	if body.is_in_group("Player"):
		node_finite_state_machine.transition_to("attack")


func _on_attack_area_body_exited(body):
	if body.is_in_group("Player"):
		node_finite_state_machine.transition_to("idle")


func _on_enemy_slime_hit():
	node_finite_state_machine.transition_to("hit")


func _on_enemy_slime_death():
	node_finite_state_machine.transition_to("death")


func _on_hit_damage_dealt():
	node_finite_state_machine.transition_to("attack")
