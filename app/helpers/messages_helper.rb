module MessagesHelper
  def message_type(type)
    return 'secondary' if type == 'notice'
    return 'danger' if type == 'error'
    return 'warning' if type == 'info'
  end
end
