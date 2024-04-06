class_name OrderRandomizer

static func randomize_array(array: Array[Order]) -> Array[Order]:
	var new_array : Array[Order] = []
	while len(array) != 0:
		var index = randi() % len(array)
		new_array.append(array.pop_at(index))
	return new_array
	
