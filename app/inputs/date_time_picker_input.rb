class DateTimePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:div, class: 'input-group date') do
      template.concat span_calendar
      template.concat @builder.text_field(attribute_name, input_html_options)
    end
  end

  def input_html_options
    super.merge({class: 'form-control', readonly: true})
  end

  def span_calendar
    template.content_tag(:span, class: 'input-group-addon') do
      template.concat icon_calendar
    end
  end


  def icon_calendar
    "<i class='fa fa-calendar'></i>".html_safe
  end



end
