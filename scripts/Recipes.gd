class_name Recipes

static var filename: String = "res://data/Recipes/%s.json"

static func get_recipe(name: String) -> Dictionary:
	var data = FileFunctions.json_get_data(filename % name, TYPE_ARRAY)
	var dict = {}
	for string in data:
		dict = make_dict_entry(string, dict)
	return dict

static func make_dict_entry(string: String, dict: Dictionary):
	var ingredient_name = ""
	var index = 0
	while string[index] != ':':
		ingredient_name += string[index]
	var amount = int(string.substr(index+1, len(string) - 1))
	dict[ingredient_name] = amount
	return dict
	
