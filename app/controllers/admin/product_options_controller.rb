class Admin::ProductOptionsController < AdminController

  def index
    @options = ProductOption.filter(params.slice(:getColorOption,:getDimensionOption))
    respond_to do |format|
      format.json do
        render json: @options
      end
    end
  end

end
