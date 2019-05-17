class MenusController < ApplicationController
  before_action :authenticate_company!
  before_action :authenticate_admin!
  before_action :find_menu, only: %i[show edit update destroy]

  def index
    respond_to do |format|
      format.html { @menus = current_company.menus.all }
      format.json { render json: MenuDatatable.new(params, current_company: current_company) }
    end
  end

  def show; end

  def new
    @menu = current_company.menus.new
    @products = current_company.products
    @categories = current_company.categories
    @menu_item = @menu.menu_items.new
  end

  def create
    @menu = current_company.menus.new(menu_params)
    if @menu.save
      redirect_to @menu, notice: 'Plato del menu creado exitosamente'
    else
      @products = current_company.products
      @categories = current_company.categories
      @menu_item = @menu.menu_items.new
      render :new
    end
  end

  def edit
    @products = current_company.products
    @categories = current_company.categories
  end

  def update
    if @menu.update(menu_params)
      redirect_to @menu, notice: 'Plato del menu actualizado exitosamente'
    else
      @products = current_company.products
      @categories = current_company.categories
      render :edit
    end
  end

  def destroy
    @menu.destroy!
    redirect_to menus_path, notice: 'Menu borrado exitosamente'
  end

  private

  def find_menu
    @menu = current_company.menus.find(params[:id])
  end

  def menu_params
    params.require(:menu).permit(:name, :price, :category_id,
                                 menu_items_attributes: %i[id product_id quantity _destroy])
  end
end
