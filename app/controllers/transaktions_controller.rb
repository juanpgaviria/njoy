class TransaktionsController < ApplicationController
  before_action :authenticate_company!
  before_action :authenticate_admin!
  before_action :find_transaktion, only: %i[show]

  def index
    @transaktions = current_company.transaktions
  end

  def new
    @transaktion = current_company.transaktions.new
  end

  def create
    @transaktion = current_company.transaktions.new(transaktion_params)
    if @transaktion.save
      flash[:notice] = 'Transacción guardada exitosamente'
      redirect_to transaktion_path(@transaktion)
    else
      render :new
    end
  end

  def show; end

  private

  def transaktion_params
    params.require(:transaktion).permit(:quantity, :kind, :product_id, :company_id, :employee_id)
  end

  def find_transaktion
    @transaktion = current_company.transaktions.find(params[:id])
  end
end
