class cola.WidgetDataModel extends cola.AbstractDataModel
	constructor: (@model, @widget) ->

	get: (path, loadMode, context) -> @widget.get(path)

	set: () ->
	flush: () ->

class cola.WidgetModel extends cola.Scope
	constructor: (@widget) ->
		@data = new cola.WidgetDataModel(@, @widget)

		widget = @widget
		@action = (name) ->
			method = widget[name]
			if method instanceof Function
				return () -> method.apply(widget, arguments)
			return cola.defaultAction[name]

	destroy: () ->
		@data.destroy?()
		return

class cola.TemplateWidget extends cola.Widget

	@ATTRIBUTES:
		template: null

	constructor: (config) ->
		@_widgetModel = new cola.WidgetModel(@)
		super(config)

	_createDom: () ->
		return cola.xRender(@_template or {}, @_widgetModel)