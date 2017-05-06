class Admin::ProductsController < AdminController

  def new
    @product = Product.new
    @photo = @product.build_photo
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path
    else
      puts "-----------------"
      puts "#{@product.errors.messages}"
      render :new
    end
  end

  def index
    @products = Product.filter(params.slice(:by_name))
    respond_to do |format|
      format.html
      format.json do
        render json: @products
      end
    end
  end

  def edit
    @product = Product.find(params[:id])
    if @product.photo.present?
      @photo = @product.photo
    else
      @photo = @product.build_photo
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end

  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
  end

  private
  def product_params
    if params.dig(:product,:photo_attributes,:images)
      params[:product][:photo_attributes][:images] = params[:product][:photo_attributes][:images].values
    end
    params.require(:product).permit(:title,:description,:quantity,:price,
                                    photo_attributes:[:id,{ images:[] }],
                                    product_options_attributes:[:id,:color_id,:dimension_id,:_destroy,
                                                                dimension_attributes:[:id,:name,:_destroy],
                                                                color_attributes:[:id,:name,:_destroy]]
                                    )
  end

end
