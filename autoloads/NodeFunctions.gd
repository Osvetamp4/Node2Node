extends Node2D


func _ready():
	pass
###function createNode()
###[Output] - Adds a new key (NodeName) to the dictionary passed to it (cMap)
###[Usage in context] - Can be used to represent the creation of a new node on a graph
###[Parameters]: nodeName, cMap
###[Parameter] nodeName - The name of the key added to the dictionary
###[Parameter] cMap    - The dictionary the key is being added to 
###[Caveat] - createNode() creates a temporary duple value of ("", 0, False) to be assigned to the key   
func createNode(nodeName, cMap):
	#cMap.update({nodeName: [["", 0, false]]})
	cMap[nodeName] = []
	#initializes as a list of lists

###function deleteNode()
###[Output] - Removes a pre-existing key (nodeName) from the dictionary passed to it (cMap)
###[Usage in context] - Can be used to represent the deletion of a node on a graph
###[Parameters]: nodeName, cMap
###[Parameter] nodeName - name of the key being removed from the dictionary
###[Parameter] cMap     - dictionary the key is being removed from
###[Caveat] deleteNode() does not store the deleted key anywhere
###[Caveat] deleteNode() does not deleted all pre-existing edges to (nodeName) in other dictionary keys - To do so, use deleteNodeClean()
func deleteNode(nodeName, cMap):
	cMap.erase(nodeName)

###function deleteNodeClean()
###[Output] - Removes a key (removeNode) and all relationships to that key stored in other keys. These keys are all contained within cMap
###[Usage in context] - Can be used to represent the deletion of a node and all edges to that node
###[Parameters]: removeNode, cMap
###[Parameter] removeNode - The key being removed
###[Parameter] cMap       - The dictionary within which (removeNode) is contained
func deleteNodeClean(removeNode, cMap):

  ##singleNodeListFirst is a {List} used to transverse through the tuple value associated wtih each key of cMap
  ##singleNodeListSecond is a {List} used to temporarily store tuples not associated with a connection to (removeNode). This {List} of tuples is cast back to a tuple and assigned as the value associated with a key 
	var singleNodeListFirst = []
	var singleNodeListSecond = []

  #Loop through every key
	for key in cMap.keys():
		singleNodeListFirst = cMap.get(key) 
		singleNodeListSecond = [] 

		for i in range (0,len(singleNodeListFirst)):
			if singleNodeListFirst[i][0] != removeNode:
				singleNodeListSecond.append(singleNodeListFirst[i])
	
		#cMap.update({key: singleNodeListSecond}) 
		cMap[key] = singleNodeListSecond
  
  #removes (removeNode) as a key
	deleteNode(removeNode, cMap)

###function checkNode()
###[Output] - checks if there is an existing {key} assigned the name (nodeName) within {dictionary} (cMap) 
###[Usage in context] - Can check if a node's name is already used before creating a node of that name.
###[Parameters] nodeName, cMap
###[Parameter] nodeName - the name of the {key} which is being checked for existence 
###[Parameter] cMap     - the {dictionary} that is being checked for {key} (nodeName)
func checkNode(nodeName, cMap): 
	var nodeDoesNotExist = false
	for key in cMap.keys():
		if key == nodeName:
			nodeDoesNotExist = true
	return nodeDoesNotExist


###function hasEdge()
###[Output] - returns true if node has any connections to any other node. 
###[Usage in context] - Can check if a node has any connections, and info can be used to either delete those edges or the node itself
###[Parameters] nodeName, cMap
###[Parameter] nodeName - the name of the {key} which is being checked for it's edges
###[Parameter] cMap     - the {dictionary} that is being checked for {key} (nodeName)
###[Pre-Condition] The node has to exist. cMap has to exist.
func hasEdge(nodeName,cMap):
	var hasEdge = false
	if len(cMap[nodeName]) > 0: hasEdge = true
	return hasEdge
