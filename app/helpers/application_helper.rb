module ApplicationHelper
  def notice_message
    alert_types = {notice: :success, alert: :danger}

    close_button_options = {class: "close", "data-dismiss" => "alert", "aria-hidden" => true}

    close_button = content_tag(:button,"x", close_button_options)

    alerts = flash.map do |type, message|
      alert_content = close_button + message
      alert_type = alert_types[type.to_sym] || type
      alert_class = "alert alert-#{alert_type} alert-dismissable"


      content_tag(:div,alert_content, class: alert_class)
    end

    alerts.join("\n").html_safe

  end

  def render_cart_items_count(cart)
    cart.cart_items.count
  end
  def is_active_controller(controller_name, class_name = nil)
    if params[:controller] == controller_name
      class_name == nil ? "active" : class_name
    else
      nil
    end
  end

  def is_active_action(action_name)
    params[:action] == action_name ? "active" : nil
  end

  def render_date_with_format(date,format)
    unless date.blank?
      date.to_s(format)
    end

  end

  def render_date_time_picker_format(date)
    if date
      date.strftime("%Y/%m/%d")
    else
      ""
    end
  end
end
