extends AbstractDay

func getTitle() -> String:
	return "Day 21: Dirac Dice"

func getInput():
	var lines = getInputAsLines()
	var posRegex = RegEx.new()
	posRegex.compile("Player (\\d) starting position: (\\d+)")
	var players = []
	var i = 0
	for line in lines:
		var regexResult = posRegex.search(line)
		players.append({
			"index": i,
			"nr": regexResult.get_string(1),
			"pos": int(regexResult.get_string(2)) - 1,
			"points": 0,
		})
		i += 1
	return players

var maxSpace = 10

func calculatePart1():
	var players = getInput()
	var maxPoints = 1000
	var rollsPerPlayer = 3
	var diceRolls = 0
	
	diceDeterministicValue = 1
	while(true):
		for player in players:
			var move = 0
			for _i in range(0, rollsPerPlayer):
				move += getDeterministicRoll()
			diceRolls += rollsPerPlayer
			player["pos"] = ((player["pos"] + move) % maxSpace)
			player["points"] += player["pos"] + 1
			if player["points"] >= maxPoints:
				Utility.log("Player nr {0} wins with {1} points!", [player["nr"], player["points"]])
				var otherPlayer = players[ (player["index"] + 1) % players.size() ]
				Utility.log("Losing player nr {0} loses with {1} points!", [otherPlayer["nr"], otherPlayer["points"]])
				return diceRolls * otherPlayer["points"]
	return 0

var diceDeterministicValue = 1
var diceDeterministicValueMax = 100
func getDeterministicRoll() -> int:
	var result = diceDeterministicValue
	diceDeterministicValue = (diceDeterministicValue % diceDeterministicValueMax) + 1
	return result
