extends Control

var fulldata = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	fulldata = Rootscene.get_estado_pedido_data()
	load_pedido_data()
	print(fulldata)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_go_back_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")

func load_pedido_data():
	var statusIndex = 0
	var PagadoIndex = 0
	var CompletedIndex = 0
	if fulldata.doc_fields.status == "por procesar":
		statusIndex = 0
	if fulldata.doc_fields.status == "consulta":
		statusIndex = 1
	if fulldata.doc_fields.status == "pedido":
		statusIndex = 2
	if fulldata.doc_fields.payment:
		PagadoIndex = 0
	else:
		PagadoIndex = 1
	if fulldata.doc_fields.completed:
		CompletedIndex = 0
	else:
		CompletedIndex = 1
		
	%NombreYProveedor.text = fulldata.doc_name + "-" + fulldata.doc_fields.provider
	%CantidadSpinBox.value = fulldata.doc_fields.amount
	%StatusSituation.select(statusIndex)
	%ETALabel.text = str(fulldata.doc_fields.ETA.day) + "/" + str(fulldata.doc_fields.ETA.month)
	%PagadoOption.select(PagadoIndex)
	%CompletedOption.select(CompletedIndex)
	

func _on_modificar_button_pressed():
	var statusIndex = "por procesar"
	var PagadoIndex = false
	var CompletedIndex = 0
	
	if %StatusSituation.get_selected_id() == 0:
		statusIndex = "por procesar"
	if %StatusSituation.get_selected_id() == 1:
		statusIndex = "consulta"
	if %StatusSituation.get_selected_id() == 2:
		statusIndex = "pedido"
	if %PagadoOption.get_selected_id() == 0:
		PagadoIndex = true
	else:
		PagadoIndex = false
	if %CompletedOption.get_selected_id() == 0:
		CompletedIndex = true
	else:
		CompletedIndex = false
	
	var etaday = int(%ETALabel.text.split("/")[0])
	var etamonth =  int(%ETALabel.text.split("/")[1])
	
	var data = {
		"ETA": {"day":etaday, "month":etamonth},
		"amount":%CantidadSpinBox.value,
		"completed":CompletedIndex,
		"container": fulldata.doc_fields.container,
		"date":{"day": fulldata.doc_fields.date.day, "month":fulldata.doc_fields.date.month},
		"payment": PagadoIndex,
		"provider":fulldata.doc_fields.provider,
		"status":statusIndex
	}
	Rootscene.create_or_update_document("Orders",fulldata.doc_name,data)
	get_tree().change_scene_to_file("res://main_menu.tscn")
