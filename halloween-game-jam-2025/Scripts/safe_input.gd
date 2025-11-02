extends LineEdit
# This script is the one from the previous answer, with an added function.

var previous_valid_text = ""
const ALLOWED_CHARACTERS = "0123456789"

func _ready():
	self.text_changed.connect(_on_text_changed)
	self.text_submitted.connect(_on_text_submitted)

func _on_text_changed(new_text: String):
	var cursor_pos = self.caret_column
	var filtered_text = ""
	
	for char in new_text:
		if char in ALLOWED_CHARACTERS:
			filtered_text += char
	
	if self.text != filtered_text:
		self.text = filtered_text
		self.caret_column = self.text.length()

# The function to process the final input
func _on_text_submitted(submitted_text: String):
	
	if submitted_text.length() == 6:
		
		
		var final_number = submitted_text.to_int()
	   
		print("Final valid input (String): ", submitted_text)
		print("Final valid input (Integer): ", final_number)
		
		
		self.text = ""
		self.release_focus()
		
	else:
		print("Error: Input must be exactly 6 digits long.")
