extends Node

static var total_coin_count : int
var total_mushroom_count = 0

func give_pickup_award(coin_value : int):
	total_coin_count += coin_value
	print("Total coins: ", total_coin_count)
	
func mushroom_award():
	total_mushroom_count += 1
	print("total mushoorm: ", total_mushroom_count)
