extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var products = await Rootscene.list_docs_and_keys("Products")
	Rootscene.update_option_button(%OptionButton,products[1])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_go_back_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")



func _on_pedir_button_pressed():
	var product_name = %OptionButton.get_item_text(%OptionButton.get_selected_id())
	var product_data = await Rootscene.get_document("Products", product_name)
	
	product_data = product_data.doc_fields
	
	var day = Time.get_date_dict_from_system().day + product_data.ETA
	var month = Time.get_date_dict_from_system().month
	

	while day > 30:
		if ( day - 30 > 0 ): 
			day = day - 30
			month = month + 1
		else:
			break
	
	var data={
		"amount": %SpinBox.value,
		"ETA": {"day":day, "month": month},
		"completed": false,
		"container": product_data.container,
		"payment": false,
		"date": {"day": Time.get_date_dict_from_system().day, "month":Time.get_date_dict_from_system().month},
		"provider": product_data.providers,
		"status": "por procesar"
	}
	
	Rootscene.create_or_update_document("Orders", product_name, data)
	get_tree().change_scene_to_file("res://main_menu.tscn")
	
