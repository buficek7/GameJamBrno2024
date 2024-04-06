class_name FileFunctions

static func json_get_data(filename: String, type):
	var file = FileAccess.open(filename, FileAccess.READ)
	var jsontext = file.get_as_text()
	var json = JSON.new()
	var error = json.parse(jsontext)
	if error != OK:
		print("JSON error ", json.get_error_message(), " in ", jsontext, " at line ", json.get_error_line())
		return null
	var data = json.data
	if typeof(data) != type:
		print("Unexpected data")
		return null
	return data
	
static func json_make_data(array, filename):
	var file = FileAccess.open(filename, FileAccess.WRITE)
	var json = JSON.new()
	var json_string = json.stringify(array)
	file.store_string(json_string)
