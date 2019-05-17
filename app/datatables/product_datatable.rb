class ProductDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    @view_columns ||= {
      name: { source: 'Product.name', cond: :like },
      price: { source: 'Product.price', cond: :eq },
      quantity: { source: 'Product.quantity', cond: :eq },
      actions: { searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        name: record.name,
        price: record.price,
        quantity: record.quantity,
        actions: actions(record)
      }
    end
  end

  def get_raw_records
    options[:current_company].products
  end

  def actions(record)
    ProductsController.render(partial: 'actions', locals: { product: record })
  end
end
