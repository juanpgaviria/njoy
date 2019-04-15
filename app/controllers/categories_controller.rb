class CategoriesController < ApplicationController
  before_action :authenticate_company!
  before_action :find_category, except: %i[index new create]

  def index
    @categories = current_company.categories.all
  end

  def show; end

  def new
    @category = current_company.categories.new
  end

  def create
    @category = current_company.categories.new(category_params)
    if @category.save
      flash[:notice] = 'Categoría creada exitosamente'
      redirect_to category_path(@category)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Categoría actualizada exitosamente'
      redirect_to category_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @category.destroy!
    flash[:notice] = 'Categoría eliminada exitosamente'
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def find_category
    @category = current_company.categories.find(params[:id])
  end
end
