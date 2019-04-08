class ProductsController < ApplicationController
  before_action :authenticate_company!
  before_action :find_product, except: %i[new create index]

  def index
    @products = current_company.products
  end

  def new
    @product = current_company.products.new
  end

  def create
    @product = current_company.products.new(product_params)
    if @product.save
      flash[:notice] = 'Producto guardado exitosamente'
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      flash[:notice] = 'Producto actualizado exitosamente'
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def show; end

  def destroy
    @product.destroy
    flash[:notice] = 'Producto eliminado exitosamente'
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :quantity, :price, :description, :brand, :category_id,
                                    :supplier_id)
  end

  def find_product
    @product = current_company.products.find(params[:id])
  end
end
