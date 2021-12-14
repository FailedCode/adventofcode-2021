extends AbstractDay

func getTitle() -> String:
	return "Day 14: Extended Polymerization"

func getInput():
	var lines = getInputAsLinesRaw()
	var polymer = lines[0]
	var rules = []
	var ruleRegex = RegEx.new()
	ruleRegex.compile("([A-Z])([A-Z]) -> ([A-Z])")
	for i in range(2, lines.size()):
		var result = ruleRegex.search(lines[i])
		rules.append({
			"searchStart": result.get_string(1),
			"searchEnd": result.get_string(2),
			"insert": result.get_string(3),
		})
	return {"polymer": polymer, "rules": rules}

func calculatePart1():
	var tmp = getInput()
	var polymer = tmp["polymer"]
	var rules = tmp["rules"]
	for i in range(0, 10):
		polymer = applyRules(polymer, rules)
	return calculatePointValue(polymer)

func applyRules(polymer, rules):
	var insertions = []
	for rule in rules:
		for p in range(1, polymer.length()):
			if polymer[p-1] == rule["searchStart"] && polymer[p] == rule["searchEnd"]:
				insertions.append({"pos": p, "char": rule["insert"]})
	
	# insertions mus be done rigth to left
	insertions.sort_custom(self, "sortbyPos")
	for i in insertions:
		polymer = polymer.insert(i["pos"], i["char"])
	
	return polymer

func sortbyPos(a, b):
	return a["pos"] > b["pos"]

func calculatePointValue(polymer):
	var count = {}
	for c in polymer:
		if !count.has(c):
			count[c] = 0
		count[c] += 1
	var mostCommonKey = null
	var leastCommonKey = null
	for key in count.keys():
		if mostCommonKey == null || count[mostCommonKey] < count[key]:
			mostCommonKey = key
		if leastCommonKey == null || count[leastCommonKey] > count[key]:
			leastCommonKey = key
#	Utility.log("least common: {0} ({1})", [leastCommonKey, count[leastCommonKey]])
#	Utility.log("most common: {0} ({1})", [mostCommonKey, count[mostCommonKey]])
	return count[mostCommonKey] - count[leastCommonKey]
