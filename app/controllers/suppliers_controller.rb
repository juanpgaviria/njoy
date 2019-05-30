class SuppliersController < ApplicationController
  before_action :authenticate_company!
  before_action :authenticate_admin!
  before_action :find_supplier, except: %i[index new create]

  def index
    @suppliers = current_company.suppliers
    respond_to do |format|
      format.html
      format.json { render json: SupplierDatatable.new(params, current_company: current_company) }
    end
  end

  def show; end

  def new
    @supplier = current_company.suppliers.new
  end

  def create
    @supplier = current_company.suppliers.new(supplier_params)
    if @supplier.save
      flash[:notice] = 'Proveedor creado exitosamente'
      redirect_to supplier_path(@supplier)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @supplier.update(supplier_params)
      flash[:notice] = 'Proveedor actualizada exitosamente'
      redirect_to supplier_path(@supplier)
    else
      render :edit
    end
  end

  def destroy
    @supplier.destroy!
    flash[:notice] = 'Proveedor eliminado exitosamente'
    redirect_to suppliers_path
  end

  private

  def supplier_params
    params.require(:supplier).permit(:name, :address, :city, :phone, :contact_name, :identification)
  end

  def find_supplier
    @supplier = current_company.suppliers.find(params[:id])
  end
end
