class OrdersController < ApplicationController
  before_action :set_board, except: :index
  before_action :set_order, except: %i[index new create]

  def new
    @order = @board.orders.new
    authorize @order
    @categories = current_company.categories.joins(:menus).distinct
    # the first category starts as active
    @menus = @categories.first.menus
  end

  def create
    @order = current_company.orders.new(order_params.merge(board: @board))
    authorize @order
    if @order.save
      redirect_to boards_path, notice: 'Orden creada exitosamente'
    else
      redirect_to new_board_order_path(@board), alert: 'Hubo un error. Intenta de nuevo'
    end
  end

  def edit
    @categories = current_company.categories.joins(:menus).distinct
    @menus = @categories.first.menus
  end

  def update
    if @order.update(order_params)
      redirect_to boards_path, notice: 'Orden actualizada exitosamente'
    else
      redirect_to edit_board_order_path(@board, @order), alert: 'Hubo un error. Intenta de nuevo'
    end
  end

  private

  def set_board
    @board = current_company.boards.find(params[:board_id])
  end

  def set_order
    @order = current_company.orders.find(params[:id])
    authorize @order
  end

  def order_params
    params.require(:order).permit(:status, :total, order_items_attributes: %i[id menu_id _destroy])
  end
end
