extends Area2D

func _ready():
	$AnimationPlayer.play("Active")


func _on_body_entered(body):
	if body.name == "Player":
		$AnimationPlayer.play("Destroyed")
		player_coin_data.coin += 1
		print("Amount of coins collected: ", player_coin_data)
		await $AnimationPlayer.animation_finished
		queue_free()
