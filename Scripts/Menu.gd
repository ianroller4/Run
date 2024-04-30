extends VBoxContainer

class_name Menu

@export var ItemPointer : Node

signal Chosen(item: Control)

func _ready():
	get_viewport().gui_focus_changed.connect(_on_focus_changed)
	ConfigFocus()

func _unhandled_input(event):
	if not visible:
		return
	
	get_viewport().set_input_as_handled()
	
	var FocusItem = GetFocused()
	
	if is_instance_valid(FocusItem) and event.is_action_pressed("ui_accept"):
		Chosen.emit(FocusItem)

func GetItems() -> Array[Control]:
	var menuItems : Array[Control] = []
	
	for child in get_children():
		if !(child is Control):
			continue
		if "Heading" in child.name:
			continue
		if "Divider" in child.name:
			continue
		menuItems.append(child)
	
	return menuItems

func ConfigFocus():
	var menuItems = GetItems()
	
	var NumItems = menuItems.size()
	
	for i in NumItems:
		
		var item : Control = menuItems[i]
		
		item.focus_mode = Control.FOCUS_ALL
		
		if i == 0:
			item.focus_neighbor_top = menuItems[NumItems - 1].get_path()
			item.focus_neighbor_left = menuItems[NumItems - 1].get_path()
			item.focus_previous = menuItems[NumItems - 1].get_path()
			item.grab_focus()
		else:
			item.focus_neighbor_top = menuItems[i - 1].get_path()
			item.focus_neighbor_left = menuItems[i - 1].get_path()
			item.focus_previous = menuItems[i - 1].get_path()
			
		if i == NumItems - 1:
			item.focus_neighbor_bottom = menuItems[0].get_path()
			item.focus_neighbor_right = menuItems[0].get_path()
			item.focus_next = menuItems[0].get_path()
		else:
			item.focus_neighbor_bottom = menuItems[i + 1].get_path()
			item.focus_neighbor_right = menuItems[i + 1].get_path()
			item.focus_next = menuItems[i + 1].get_path()

func GetFocused() -> Control:
	var FocusItem = get_viewport().gui_get_focus_owner()
	
	return FocusItem if FocusItem in get_children() else null

func UpdateSelection():
	var FocusItem = GetFocused()
	
	if is_instance_valid(FocusItem) and is_instance_valid(ItemPointer) and visible:
		var X = ItemPointer.global_position.x
		var Y = FocusItem.global_position.y
		ItemPointer.global_position = Vector2(X, Y)

func _on_focus_changed(item : Control):
	if not item or !(item in get_children()):
		return
	
	UpdateSelection()
