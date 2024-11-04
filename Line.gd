extends Node2D
var fromNode = "NodeFrom"
var toNode = "NodeTo"
var nodeNames = []
var nodeCoords = []
var weight = 0
var fromNodeCoord = Vector2(0,0)
var toNodeCoord = Vector2(0,0)
var col = Color(255,255,0)
func _ready():
	add_to_group("edges")
	var xDistance = abs(fromNodeCoord[0] - toNodeCoord[0])#Calculates length of the edge
	var yDistance = abs(fromNodeCoord[1] - toNodeCoord[1])
	var HypDistance = xDistance *xDistance + yDistance *yDistance
	var realHypDistance = round(sqrt(HypDistance))
	weight = realHypDistance
	$Label.text = str(weight)
	if fromNodeCoord[0] > toNodeCoord[0]:#If fromNode is to the right of toNode
		$Label.rect_global_position.x = fromNodeCoord[0] - xDistance/2
	elif fromNodeCoord[0] <= toNodeCoord[0]:#If fromNode is to the left of toNode
		$Label.rect_global_position.x = fromNodeCoord[0] + xDistance/2
	
	if fromNodeCoord[1] > toNodeCoord[1]:#If fromNode is below toNode
		$Label.rect_global_position.y = fromNodeCoord[1] - yDistance/2
	elif fromNodeCoord[1] <= toNodeCoord[1]:#If fromNode is above toNode
		$Label.rect_global_position.y = fromNodeCoord[1] + yDistance/2
	

func _physics_process(delta):
	pass

func _draw():#Automatically draws when instanced the coordinates as directed by Main
	draw_line(fromNodeCoord,toNodeCoord,col)
	
	

func erase():#Removes itself, and therefore the line.
	queue_free()


