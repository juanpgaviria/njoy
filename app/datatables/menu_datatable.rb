class MenuDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    @view_columns ||= {
      name: { source: 'Menu.name', cond: :like },
      price: { source: 'Menu.price', cond: :eq },
      category: { source: 'Category.name', cond: :like },
      actions: { searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        name: record.name,
        price: record.price,
        category: record.category.name,
        actions: actions(record)
      }
    end
  end

  def get_raw_records
    options[:current_company].menus.joins(:category)
  end

  def actions(record)
    MenusController.render(partial: 'actions', locals: { menu: record })
  end
end
