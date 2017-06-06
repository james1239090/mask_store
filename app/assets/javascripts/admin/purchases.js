function paramformat(item) {
	return item.title;
}

function removeOption(selecter) {
	selecter.find('option').remove();
}

function initDefaultSelectProduct(item) {
	removeOption(item.find(".select_product"));
	removeOption(item.find(".select_color"));
	removeOption(item.find(".select_dimension"));

	var url = "/admin/products.json",
		selectFrom = item.find(".select_product").data('selectfrom');

	item.find(".select_product").select2({
		ajax: {
			url: url,
			dataType: 'json',
			delay: 250,
			data: function(params) {
				if (params.term === undefined && selectFrom === "sale") {
					return {
						get_inventory: 0
					};
				} else if (selectFrom === "purchase") {
					return {
						q_name: params.term // search term
					};
				} else {
					return {
						q_name_with_inven: params.term // search term
					};
				}

			},
			processResults: function(data, params) {
				data.splice(0, 0, {
					id: -1,
					text: 'Select an Product'
				});
				params.page = params.page || 1;
				return {
					results: data,
					pagination: {
						more: (params.page * 30) < data.total_count
					}
				};
			},
			placeholder: {
				id: '-1',
				text: 'Select an Product'
			},
			cache: true,
		},
		theme: "bootstrap",
		escapeMarkup: function(markup) {
			return markup;
		},
		minimumInputLength: 0,
		templateSelection: paramformat,
		templateResult: paramformat
	});
}

function initDefaultSelectColorAndDimension(item) {
	$('.select_color, .select_dimension').select2({
		theme: "bootstrap",
		escapeMarkup: function(markup) {
			return markup;
		},
		placeholder: {
			id: '-1',
			text: 'Select an Option'
		}
	});
}

function addListenerOnSelectProduct(item) {
	$('.select_product').on('select2:select', function(e) {
		var product_id = $(this).val(),
			$selct_color = $(this).parent().parent().parent('.row').find('.select_color');

		var url = "/admin/product_options.json",
			selectFrom = item.find(".select_product").data('selectfrom'),
			paramsData;

		if (selectFrom === "sale") {
			url = "/admin/inventories.json";
		}

		$.ajax({
			url: url,
			dataType: "JSON",
			data: {
				getColorOption: product_id
			},
			success: function(data) {
				removeOption($selct_color);
				$selct_color.select2({
					data: data,
					placeholder: {
						id: '-1', // the value of the option
						text: 'Select Color'
					}
				}).select2('val', -1);
			}
		});
	});
}

function addListenerOnSelectColor(item) {
	$('.select_color').on('select2:select', function(e) {
		var color_id = $(this).val(),
			$select_product = $(this).parent().parent().parent('.row').find('.select_product'),
			$selct_dimension = $(this).parent().parent().parent('.row').find('.select_dimension');

		var url = "/admin/product_options.json",
			selectFrom = item.find(".select_product").data('selectfrom');

		if (selectFrom === "sale") {
			url = "/admin/inventories.json";
		}
		$.ajax({
			url: url,
			dataType: "JSON",
			data: {
				getDimensionOption: [$select_product.val(), color_id]
			},
			success: function(data) {
				removeOption($selct_dimension);
				$selct_dimension.select2({
					data: data,
					placeholder: {
						id: '-1', // the value of the option
						text: 'Select Dimension'
					}
				}).select2('val', -1);
			}
		});
	});
}

$(document).on('ready', function() {
	$(document).on('cocoon:after-insert', 'form', function(e, addItem) {
		initDefaultSelectProduct(addItem);
		initDefaultSelectColorAndDimension(addItem);
		addListenerOnSelectProduct(addItem);
		addListenerOnSelectColor(addItem);
	});
});
