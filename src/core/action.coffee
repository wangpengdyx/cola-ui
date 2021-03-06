defaultActionTimestamp = 0

cola.defaultAction = (name, fn)->
	return unless name

	if typeof name is "string" and typeof fn is "function"
		cola.defaultAction[name] = fn
	else if typeof name is "object"
		for n of name
			cola.defaultAction[n] = name[n] if name.hasOwnProperty(n)
	defaultActionTimestamp = cola.uniqueId()
	return

cola.defaultAction.get = (path)-> @get(path)

cola.defaultAction["default"] = (value, defaultValue = "")-> value or defaultValue

cola.defaultAction["int"] = (value)-> +value or 0
cola.defaultAction["float"] = (value)-> +value or 0

cola.defaultAction["bool"] = (value)-> !!value
cola.defaultAction["is"] = cola.defaultAction["bool"]
cola.defaultAction["not"] = (value)-> !value

cola.defaultAction.isEmpty = (value)->
	if value instanceof Array
		return value.length is 0
	else if value instanceof cola.EntityList
		return value.entityCount is 0
	else if typeof value is "string"
		return value is ""
	else
		return not value

cola.defaultAction.isNotEmpty = (value)-> not cola.defaultAction.isEmpty(value)

cola.defaultAction.state = (entity)-> entity?.state

cola.defaultAction.len = (value)->
	if not value
		return 0
	if value instanceof Array or typeof value is "string"
		return value.length
	if  value instanceof cola.EntityList
		return value.entityCount
	return 0

cola.defaultAction["upperCase"] = (str)-> str?.toUpperCase()
cola.defaultAction["lowerCase"] = (str)-> str?.toLowerCase()
cola.defaultAction["capitalize"] = (str)-> cola.util.capitalize(str)

cola.defaultAction["escape"] = escape
cola.defaultAction["unescape"] = unescape

cola.defaultAction.resource = (key, params...)-> cola.resource(key, params...)

cola.defaultAction.filter = cola.util.filter
	
cola.defaultAction.sort = cola.util.sort

cola.defaultAction["top"] = (collection, top = 1)->
	return null unless collection
	return collection if top < 0
	items = []
	items.$origin = collection.$origin or collection

	i = 0
	cola.each collection, (item)->
		i++
		items.push(item)
		return i < top
	return items

cola.defaultAction.now = (value)-> new Date()

cola.defaultAction.toJSON = (data)->
	if data instanceOf cola.Entity or data instanceOf cola.EntityList
		return data.toJSON()
	return data

cola.defaultAction.map = (str)->
	return cola.util.parseStyleLikeString(str)

cola.defaultAction.formatDate = cola.util.formatDate

cola.defaultAction.formatNumber = cola.util.formatNumber

cola.defaultAction.format = cola.util.format

cola.defaultAction.caption = (path)->
	caption = ""
	i = path.indexOf(".")
	if i > 0
		dataType = path.substring(0, i)
		property = path.substring(i + 1)
		dataType = @definition(dataType)
		if dataType
			property = dataType.getProperty(property)
			if property
				caption = property._caption or property._property
	return caption

_numberWords = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen"]
cola.defaultAction.number2Word = (number)-> _numberWords[number]
		
cola.defaultAction.path = (parts...)-> cola.util.path(parts)

cola.defaultAction.dictionary = (dictionaryName)->
	cola.util.dictionary(dictionaryName)

cola.defaultAction.translate = (dictionaryName, key)->
	cola.util.translate(dictionaryName, key)