extends Area2D
export var icon = "house"
var house = load("res://Assets/kenney_boardgameicons/PNG/Default (64px)/structure_house.png")
var rook = load("res://Assets/kenney_boardgameicons/PNG/Default (64px)/structure_tower.png")
var castle = load("res://Assets/kenney_boardgameicons/PNG/Default (64px)/structure_gate.png")
var barn = load("res://Assets/kenney_boardgameicons/PNG/Default (64px)/structure_farm.png")
var church = load("res://Assets/kenney_boardgameicons/PNG/Default (64px)/structure_church.png")
var nodeName = "Node"
var slowDown = true
func _ready():
	add_to_group("nodes")
	
	$Sprite2.visible = false
	$Label.text = nodeName
	if icon == "house": $Sprite.texture = house
	if icon == "rook": $Sprite.texture = rook
	if icon == "castle": $Sprite.texture = castle
	if icon == "barn": $Sprite.texture = barn
	if icon == "church": $Sprite.texture = church
	#position.x = get_global_mouse_position()[0]
	#position.y = get_global_mouse_position()[1]

func isSprite2Visible():
	if $Sprite2.visible == true: return true
	else: return false


func _physics_process(delta):
	pass


func remove_all_circle():
	$Sprite2.visible = false



func add_all_circle():
	$Sprite2.visible = true





func _on_Icon_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:# event.is_pressed()
		if Input.is_action_just_pressed("Click"):
			
			
			if Main.mode == "delete":
				print("*screams of agony*")
				
				
				#BACK_END STUFF STARTS HERE
				if NodeFunctions.hasEdge(nodeName,Main.roadMap) == true:#This if statement block removes visual representation of the edges
					for i in Main.roadMap[nodeName]:
						var targetNode = i[0]
						var edges_group = get_tree().get_nodes_in_group("edges")
						for line in edges_group:
							var node1 = line.nodeNames[0]
							var node2 = line.nodeNames[1]
							if (targetNode == node1 or targetNode == node2) and (nodeName == node1 or nodeName == node2):
								line.queue_free()
				NodeFunctions.deleteNodeClean(nodeName,Main.roadMap)#Delete dictionary representation of node and corresponding edges.
				queue_free()
			elif Main.mode == "add_edge" or Main.mode == "remove_edge" or Main.mode == "calculate_path":
				$Sprite2.visible = true
				if len(Main.edge_list) == 2: Main.edge_list.remove(0)
				Main.edge_list.append([Vector2(position.x,position.y),nodeName])
				
				
			else: print("catch all")
