$(function() {
  function paramformat(item) {
    return item.title;
  }

  function reformat(data, type) {
    var type_id = type + "_id",
      type_name = type,
      first_option = {
        id: -1,
        text: 'Select ' + type_name
      };

    var newData = data.map(function(item, index) {
      return {
        id: item[type_id],
        text: item[type_name].name
      };
    });
    newData.splice(0, 0, first_option);
    return newData;
  }

  function removeOption(selecter) {
    selecter.find('option').remove();
  }

  function initDefaultSelectProduct(item) {
    removeOption(item.find(".select_product"));
    item.find(".select_product").select2({
      ajax: {
        url: "/admin/products.json",
        dataType: 'json',
        delay: 250,
        data: function(params) {
          return {
            by_name: params.term // search term
          };
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
    item.find('.select_color, .select_dimension').select2({
      theme: "bootstrap",
      placeholder: {
        id: '-1', // the value of the option
        text: 'Select an option'
      },
      escapeMarkup: function(markup) {
        return markup;
      }, // let our custom formatter work
      minimumInputLength: 0
    });
  }

  function addListenerOnSelectProduct(item) {
    item.find('.select_product').on('select2:select', function(e) {
      var product_id = $(this).val(),
        $selct_color = $(this).parent().parent().parent('.row').find('.select_color');

      $.ajax({
        url: "/admin/product_options.json",
        dataType: "JSON",
        data: {
          g_id: "color_id",
          p_id: product_id
        },
        success: function(data) {
          removeOption($selct_color);
          $selct_color.select2({
            data: reformat(data, "color"),
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
    item.find('.select_color').on('select2:select', function(e) {
      var color_id = $(this).val(),
        $select_product = $(this).parent().parent().parent('.row').find('.select_product'),
        $selct_dimension = $(this).parent().parent().parent('.row').find('.select_dimension');
      $.ajax({
        url: "/admin/product_options.json",
        dataType: "JSON",
        data: {
          g_id: "dimension_id",
          c_id: color_id,
          p_id: $select_product.val()
        },
        success: function(data) {
          removeOption($selct_dimension);
          $selct_dimension.select2({
            data: reformat(data, "dimension"),
            placeholder: {
              id: '-1', // the value of the option
              text: 'Select Dimension'
            }
          }).select2('val', -1);
        }
      });
    });
  }

  $('form').on('cocoon:after-insert', function(e, addItem) {
    initDefaultSelectProduct(addItem);
    initDefaultSelectColorAndDimension(addItem);
    addListenerOnSelectProduct(addItem);
    addListenerOnSelectColor(addItem);
  });
});
