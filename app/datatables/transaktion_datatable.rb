class TransaktionDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    @view_columns ||= {
      product: { source: 'Product.name', cond: :like },
      kind: { source: 'Transaktion.kind', cond: :like },
      quantity: { source: 'Transaktion.quantity', cond: :eq },
      actions: { searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        product: record.product.name,
        kind: record.kind,
        quantity: record.quantity,
        actions: actions(record)
      }
    end
  end

  def get_raw_records
    options[:current_company].transaktions.joins(:product)
  end

  def actions(record)
    TransaktionsController.render(partial: 'actions', locals: { transaktion: record })
  end
end
