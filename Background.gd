extends Node2D


func _ready():
	$Mode.text = "Current Mode: " + Main.mode

func _physics_process(delta):
	if Input.is_action_just_pressed("u"):
		Main.resetGraphics()
	if Input.is_action_just_pressed("c"):
		for i in Main.roadMap:
			print(i + ": ",Main.roadMap[i])
	elif Input.is_action_just_pressed("right_click"):
		Main.modeIndex +=1
		if Main.modeIndex == len(Main.modeWheel): Main.modeIndex = 0
		Main.mode = Main.modeWheel[Main.modeIndex]
		$Mode.text = "Current Mode: " + Main.mode
		print(Main.mode)
	elif Input.is_action_just_pressed("enter"):
		get_tree().call_group("nodes","remove_all_circle")
		if len(Main.edge_list) == 2:
			
			if Main.mode == "add_edge" and EdgeFunctions.checkEdge(Main.edge_list[0][1],Main.edge_list[1][1],Main.roadMap) == false:
				var line_instance = load("res://Line.tscn").instance()
				line_instance.fromNodeCoord = Main.edge_list[0][0]#Gives the edge information.
				line_instance.toNodeCoord = Main.edge_list[1][0]
				
				
				line_instance.nodeNames.append(Main.edge_list[0][1])
				line_instance.nodeCoords.append(Main.edge_list[0][0])
				
				line_instance.nodeNames.append(Main.edge_list[1][1])
				line_instance.nodeNames.append(Main.edge_list[1][0])
				add_child(line_instance)
				Main.edge_list.clear()
				
				
				#BACK_END STUFF STARTS HERE
				
				EdgeFunctions.createEdge(line_instance.nodeNames[0],line_instance.nodeNames[1],line_instance.weight,Main.roadMap)
			elif Main.mode == "remove_edge" and EdgeFunctions.checkEdge(Main.edge_list[0][1],Main.edge_list[1][1],Main.roadMap) == true:
				var targetNode1 = Main.edge_list[0][1]
				var targetNode2 = Main.edge_list[1][1]
				var edges_group = get_tree().get_nodes_in_group("edges")
				for line in edges_group:
					var node1 = line.nodeNames[0]
					var node2 = line.nodeNames[1]
					if (targetNode1 == node1 or targetNode1 == node2) and (targetNode2 == node1 or targetNode2 == node2):
						line.queue_free()#Remove edge visualization(It has to. This if statement should run no matter what)
					EdgeFunctions.deleteEdge(targetNode1,targetNode2,Main.roadMap)
			elif Main.mode == "calculate_path":
				var startNode = Main.edge_list[0][1]
				var endNode = Main.edge_list[1][1]
				var solution = Main.getShortestPath(startNode,endNode,Main.roadMap)
				print(solution)
				Main.decodeGraphics(solution[0])
				$TotalDistance.text = "Total distance: "+str(solution[1])
	elif Input.is_action_just_pressed("Click"):
		if Main.mode == "create":
			print("created")
			Main.nodeNum+=1
			var icon_instance = load("res://House.tscn").instance()
			icon_instance.position = get_global_mouse_position()
			icon_instance.nodeName = "Node" + str(Main.nodeNum)
			add_child(icon_instance)
			
			
			
			#BACK_END STUFF STARTS HERE
			
			NodeFunctions.createNode(icon_instance.nodeName,Main.roadMap)
		if Main.mode == "add_edge" or Main.mode == "remove_edge":
			#var iterated = get_tree().get_nodes_in_group("nodes")
			pass
		if Main.mode == "delete":
			pass
		if Main.mode == "calculate_path":
			pass
