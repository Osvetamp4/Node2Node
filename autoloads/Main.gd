extends Node2D

var modeWheel = ["create","delete","add_edge","remove_edge","calculate_path"]
var modeIndex = 0
var mode = modeWheel[modeIndex]
var edge_list = []#for edge plotting
var ref_list = []#for referring to specific nodes
var nodeNum = 0#To add +1 to name of new nodes

"""
var roadMap = {
  "a":[["b", 1, true], ["d", 3, true]],
  "b":[["a", 1, true], ["c", 2, true], ["e", 1, true]],
  "c":[["b", 2, true], ["f", 2, true]],
  "d":[["a", 3, true], ["e", 1, true], ["g", 5, true]],
  "e":[["d", 1, true], ["f", 1, true], ["b", 1, true], ["h", 1, true]],
  "f":[["d", 5, true], ["h", 1, true]],
  "g":[["g", 1, true], ["h", 1, true]],
  "h":[["g", 1, true], ["i", 2, true], ["e", 1, true]],
  "i":[["h", 2, true], ["f", 6, true]]
}
"""

var roadMap = {
	
}

func _ready():
	pass
# warning-ignore:unused_argument

var pathList = []#VERY IMPORTANT LIST. Workaround for recursive function voodoo magic.


func shortestPath(startNode,endNode,currentNode,nodePath,smallMap):#Finds all possible routes to destination. nodePath explained in line 22
  
  
	if currentNode == endNode: return nodePath
  
  #Go through all connection tuples inside big tuple for this node and update/add new routes to pathList,
	for i in range(len(smallMap[currentNode])-1,-1,-1):#goes through big tuple backwards.

	
		var currentNodeSub = smallMap[currentNode][i][0] #Gets name of new node in connection tuple

		if smallMap[currentNode][i][2] == false: continue
		if currentNodeSub in nodePath[0]:continue #if new node is in our nodePath(ie: we already passed through this node before) we ignore and move onto next connection tuple and new node.

	  
		var nodeToNode =nodePath[0] + currentNodeSub#we add new node to NodePath, signifying we are going through the node in our path.

	
		var weight = nodePath[1] + smallMap[currentNode][i][1]#add weight num inside connection tuple to total weight.
	
		var nodePathSub = [nodeToNode,weight] #Make updated nodepath with our calculations.

	
		if i != 0: pathList.append(shortestPath(startNode,endNode,currentNodeSub,nodePathSub,smallMap))#add new route to pathList to calculate/update itself if there are more than one new connection.

	  
		else:
			if currentNode == startNode:pathList.append(shortestPath(startNode,endNode,currentNodeSub,nodePathSub,smallMap))
			return shortestPath(startNode,endNode,currentNodeSub,nodePathSub,smallMap)#Simply just update itself and not add new connections if there is only one valid new connection.

func getShortestPath(startNode,endNode,smallMap):#You should be only using THIS method. shortestPath is technically a helper method.
	shortestPath(startNode,endNode,startNode,[startNode,0],smallMap)
	var thisIsATuple = []
	var newPathList = []
	for i in pathList:
		if typeof(i) == typeof(thisIsATuple):newPathList.append(i)#copy over to new list, so we don't need to worry about None values appearing.

	if len(newPathList) == 0: return "No path possible."

	var mini = newPathList[0][1]
	var path = newPathList[0][0]
	for i in newPathList:#Find shortest path out of all availible paths. It's very easy,find min and boom.
		if i[1] < mini: 
			mini = i[1]
			path = i[0]
	pathList.clear()
	return [path,mini]



func resetGraphics():
	var edges_group = get_tree().get_nodes_in_group("edges")
	for line in edges_group:
		line.col = Color(255,255,0)
		line.update()

func decodeGraphics(pathLine):
	pathLine = pathLine.split("Node")
	var nameLine = []
	for i in pathLine:
		var nodeFinder = "Node" + str(i)
		if nodeFinder == "Node": continue
		nameLine.append(nodeFinder)
		
		
	
	for i in range(len(nameLine)):
		if i == 0: continue
		var targetNode1 = nameLine[i-1]
		var targetNode2 = nameLine[i]
		var edges_group = get_tree().get_nodes_in_group("edges")
		for line in edges_group:#Each line scene will have two node ending points.
			var lineNode1 = line.nodeNames[0]
			var lineNode2 = line.nodeNames[1]
			if (targetNode1 == lineNode1 or targetNode1 == lineNode2) and (targetNode2 == lineNode1 or targetNode2 == lineNode2):
				#we know these are the correct nodes to use!
				line.col = Color(0,255,0)
				line.update()
