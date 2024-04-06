class_name Order

var recipe_name : String
var order_string : String

static func make_order(content : String) -> Order:
	var new_recipe_name = ""
	var index = 0
	while content[index] != '-':
		new_recipe_name += content[index]
		index += 1
	var new_order = Order.new()
	new_order.recipe_name = new_recipe_name
	new_order.order_string = content.substr(index + 1, len(content) - 1)
	return new_order

func get_name():
	return recipe_name

func get_desc():
	return order_string
