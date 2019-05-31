class EmployeeDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    @view_columns ||= {
      names: { source: 'Employee.names', cond: :like },
      last_names: { source: 'Employee.last_names', cond: :like },
      phone: { source: 'Employee.phone', cond: :like },
      email: { source: 'Employee.email', cond: :like },
      actions: { searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        names: record.names,
        last_names: record.last_names,
        phone: record.phone,
        email: record.email,
        actions: actions(record)
      }
    end
  end

  def get_raw_records
    options[:current_company].employees
  end

  def actions(record)
    EmployeesController.render(partial: 'actions', locals: { employee: record })
  end
end
