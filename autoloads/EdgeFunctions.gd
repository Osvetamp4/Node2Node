extends Node2D


func _ready():
	pass
###function alterEdge()
###[Output] - sets the boolean in a connection's info 
###removes an edge (connection between two nodes) 
###can be used to represent the placement and/or removal of a wall 
###parameters: nodeA; nodeB; cMap; alterBoolean 
###[Parameter] nodeA        - dictionary key of one of the nodes of the edge
###[Parameter] nodeB        - dictionary key of the other node of the edge
###[Parameter] cMap         - the dictionary representing the graph in which nodeA and nodeB are contained
###[Parameter] alterBoolean - the boolean value the connections are being set to
###[Pre-condition] nodeA and nodeB must have an edge between them
func alterEdge(nodeA, nodeB, cMap, alterBoolean):
  
	for indexA in range(len(cMap.get(nodeA)) ):
		if cMap.get(nodeA)[indexA][0] == nodeB:
			cMap.get(nodeA)[indexA][2] = alterBoolean

	for indexB in range(len(cMap.get(nodeB)) ):
		if cMap.get(nodeB)[indexB][0] == nodeA:
			cMap.get(nodeB)[indexB][2] = alterBoolean


###function createEdge()
###[Output] - Adds a new tuple value to keys (nodeA) and (nodeB) in dictionary (cMap)
###[Usage in context] - Can be used to represent the creation of an edge between two nodes on a graph
###[Parameters]: nodeA, nodeB, weight, cMap
###[Parameter] nodeA  - Name of first node for new edge 
###[Parameter] nodeB  - Name of second node for new edge
###[Parameter] weight - Weight given to the new edge
###[Parameter] cMap   - Dictionary that the new edge is being added to
###[Precondition] - Nodes must exist and cMap must exist
func createEdge(nodeA, nodeB, weight, cMap):
  #Used to alter the contents of the lists at keys (nodeA) and (nodeB)
	var holderList = [] 

	holderList = cMap.get(nodeA)
	holderList.append([nodeB, weight, true])
	if holderList[0] == ["", 0, false]: 
		holderList.erase(0)
	#cMap.update({nodeA: holderList})
	cMap[nodeA] = holderList

	holderList = cMap.get(nodeB)
	holderList.append([nodeA, weight, true])  
	if holderList[0] == ["", 0, false]: 
		holderList.erase(0)
	#cMap.update({nodeB: holderList})
	cMap[nodeB] = holderList


###function deleteEdge()
###[Output] - Removes the tuples signifying a relationship between two keys
###[Usage in context] - Can be used to represent the deletion of an edge between two nodes on a graph
###[Parameters]: nodeA, nodeB, cMap
###[Parameter] nodeA - Name of one of the nodes the edge to be removed is connected to 
###[Parameter] nodeB - Name of the other node the edge to be removed is connected to
###[Parameter] cMap  - The dictionary within which the nodes are contained
###[Caveat] - The deleted edge is not stored anywhere 
###[Precondition] - The nodes must exist, there must be an edge between, cMap must exist
func deleteEdge(nodeA, nodeB, cMap):
  #Used to alter contents of the tuple at keys (nodeA) and (nodeB)
	var holderList = []
	var holderListTwo = []

	holderList = cMap.get(nodeA)
	for i in range(0, len(holderList)):
		if holderList[i][0] != nodeB:
			holderListTwo.append(holderList[i])
	#cMap.update({nodeA: holderListTwo})
	cMap[nodeA] = holderListTwo

	holderListTwo = []
	holderList = cMap.get(nodeB)
	for i in range(0, len(holderList)):
		if holderList[i][0] != nodeA:
			holderListTwo.append(holderList[i])
	#cMap.update({nodeB: holderListTwo})
	cMap[nodeB] = holderListTwo

###function checkEdge()
###[Return] - Returns {False} if there is no existing relationship between {keys} (nodeA) and (nodeB). Returns {True} if there is an existing relationship. These {keys} are contained within the {dictionary} (cMap). 
###[Usage in context] - Can be used to check if there is an existing edge between nodes (nodeA) and (nodeB) on the graph (cMap)  
###[Parameters]: nodeA, nodeB, cMap
###[Parameter] nodeA - Name of one of the nodes to be checked
###[Parameter] nodeB - Name of the other node to be checked
###[Parameter] cMap  - The {dictionary} within which nodes (nodeA) and (nodeB) are contained
###[Precondition] Nodes must exist, cMap must exist
func checkEdge(nodeA, nodeB, cMap):
	var holderList = cMap.get(nodeA)
	var edgeDoesNotExist = false

	for i in range(0, len(holderList)):
		if holderList[i][0] == nodeB: 
			edgeDoesNotExist = true
 
	return edgeDoesNotExist
