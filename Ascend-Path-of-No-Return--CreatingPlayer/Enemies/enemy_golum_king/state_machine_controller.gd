extends Node

@export var character_body_2d : CharacterBody2D
@export var node_finite_state_machine : NodeFiniteStateMachine

func _on_slam_attack_area_body_entered(body):
	if body.is_in_group("Player") and character_body_2d.can_attack:
		node_finite_state_machine.transition_to("slamattack")

func _on_slam_attack_area_body_exited(body):
	if body.is_in_group("Player") and character_body_2d.can_attack:
		node_finite_state_machine.transition_to("rangedattack")

func _on_ranged_attack_area_body_entered(body):
	if body.is_in_group("Player") and character_body_2d.can_attack:
		node_finite_state_machine.transition_to("rangedattack")

func _on_ranged_attack_area_body_exited(body):
	if body.is_in_group("Player") and character_body_2d.can_attack:
		node_finite_state_machine.transition_to("idle")

func _on_enemy_golum_king_death_signal():
	node_finite_state_machine.transition_to("death")

func _on_hit_damage_dealt():
	node_finite_state_machine.transition_to("slamattack")


func _on_enemy_golum_king_hit():
	node_finite_state_machine.transition_to("hit")
