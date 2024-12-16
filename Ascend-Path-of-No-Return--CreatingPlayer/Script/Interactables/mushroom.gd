extends Area2D

static var collected = false

func _ready():
	if collected:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		collected = true
		queue_free()
		CollectibleManager.mushroom_award()
