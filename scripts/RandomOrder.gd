class_name OrderRandomizer

static func randomize_array(array: Array[Order], level: int) -> Array[Order]:
	var tutorial = null
	if level == 1:
		tutorial = array.pop_back()
	var new_array : Array[Order] = []
	while len(array) != 0:
		var index = randi() % len(array)
		new_array.append(array.pop_at(index))
	if level == 1:
		new_array.append(tutorial)
	return new_array
	
