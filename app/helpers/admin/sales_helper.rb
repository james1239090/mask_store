module Admin::SalesHelper
  def render_profit_rate(rate)
    number_to_percentage(rate*100,precision: 2)
  end
end
