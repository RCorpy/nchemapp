extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var result = await Rootscene.get_listas()
	
	var contenedores = result[0]
	var unidades = result[1]
	var proveedores = await Rootscene.list_docs_and_keys("Proveedores")
		
	Rootscene.update_option_button(%ProveedoresOptionButton,proveedores[1])
	Rootscene.update_option_button(%OptionButton, contenedores) #contenedores
	Rootscene.update_option_button(%OptionButton2, unidades) #unidades
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_go_back_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_crear_button_pressed():
	var provider
	if %ProveedoresOptionButton.get_selected_id()>-1:
		provider = %ProveedoresOptionButton.get_item_text(%ProveedoresOptionButton.get_selected_id())
	else:
		provider = "unknown"
	
	var data ={
		"ETA": %ETASpinBox.value, #dias para que llegue aprox
		"container": %OptionButton.get_item_text(%OptionButton.get_selected_id()),
		"price": %PriceSpinBox.value,
		"price_date":{"day": Time.get_date_dict_from_system().day, "month":Time.get_date_dict_from_system().month},
		"providers":  provider,
		"units":  %OptionButton2.get_item_text(%OptionButton2.get_selected_id()),
	}	
	
	Rootscene.create_or_update_document("Products", %NombreLineEdit.text.to_upper(), data)
	get_tree().change_scene_to_file("res://main_menu.tscn")
