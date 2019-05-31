class SupplierDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    @view_columns ||= {
      name: { source: 'Supplier.name', cond: :like },
      phone: { source: 'Supplier.phone', cond: :like },
      contact_name: { source: 'Supplier.contact_name', cond: :like },
      products: {
        source: 'Supplier.products.count', cond: :eq, searchable: false, orderable: false
      },
      actions: { searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        name: record.name,
        phone: record.phone,
        contact_name: record.contact_name,
        products: record.products.count,
        actions: actions(record)
      }
    end
  end

  def get_raw_records
    options[:current_company].suppliers
  end

  def actions(record)
    SuppliersController.render(partial: 'actions', locals: { supplier: record })
  end
end
