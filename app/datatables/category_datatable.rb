class CategoryDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    @view_columns ||= {
      name: { source: 'Category.name', cond: :like },
      description: { source: 'Category.description', cond: :like },
      products: { source: 'Category.products.count',cond: :eq, searchable: false, orderable: false},
      actions: { searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        name: record.name,
        description: record.description,
        products: record.products.count,
        actions: actions(record)
      }
    end
  end

  def get_raw_records
    options[:current_company].categories
  end

  def actions(record)
    CategoriesController.render(partial: 'actions', locals: { category: record })
  end
end
