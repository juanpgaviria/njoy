class BoardsController < ApplicationController
  before_action :authenticate_company!
  before_action :authenticate_admin!, except: :index
  before_action :find_board, only: %i[edit update destroy]

  def index
    @boards = current_company.boards.decorate
  end

  def new
    @board = current_company.boards.build
  end

  def create
    @board = current_company.boards.create(board_params).decorate
  end

  def edit
    @board = @board.decorate
  end

  def update
    @board.update!(board_params)
    return head :ok unless params[:from_form]

    @board = @board.decorate
  end

  def destroy
    @board.delete
  end

  # drag and drop, resizing boards
  def positions
    @boards = current_company.boards.decorate
  end

  private

  def board_params
    params.require(:board).permit(:pos_x, :pos_y, :number, :width, :height)
  end

  def find_board
    @board = current_company.boards.find(params[:id])
  end
end
