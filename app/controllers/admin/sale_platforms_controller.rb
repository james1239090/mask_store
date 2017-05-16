class Admin::SalePlatformsController < AdminController
  before_action :find_sale_platform , only: [:show, :edit, :update, :destroy]
  def index
    @sale_platforms = SalePlatform.all
  end

  def new
    @sale_platform = SalePlatform.new
  end

  def create
    @sale_platform = SalePlatform.new(sale_platform_params)

    if @sale_platform.save
      redirect_to admin_sale_platforms_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @sale_platform.update(sale_platform_params)
      redirect_to admin_sale_platforms_path
    else
       render :edit
    end
  end

  def destroy
    @sale_platform.destroy
    redirect_to admin_sale_platforms_path
  end


  private
  def sale_platform_params
    params.require(:sale_platform).permit(:service_rate, :name)
  end

  def find_sale_platform
    @sale_platform = SalePlatform.find(params[:id])
  end
end
