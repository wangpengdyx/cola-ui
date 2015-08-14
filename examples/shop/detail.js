cola(function (model, param) {
	model.set({
		"product": model.wrapper({
			url: "items/item.json?itemId=" + param.itemId
		}),
		"recommandedProducts": model.wrapper({
			url: "items/recommanded.json"
		})
	});

	model.action({});

	model.widgetConfig({
		listRecommandedProducts: {
			$type: "listView",
			class: "product-list lightgrey",
			bind: "product in recommandedProducts",
			columns: "3 6 9 12",
			highlightCurrentItem: false
		},
		buttonFavorite: {
			$type: "button",
			class: "orange",
			icon: "star"
		},
		buttonAddToCart: {
			$type: "button",
			class: "red",
			icon: "add to cart",
			caption: "Buy"
		}
	});
});