module NavbarHelper
  def root_title
    company_signed_in? ? current_company.name.titleize : 'nJoy'
  end

  def show_boards_button
    button = if controller_name == 'boards' && action_name == 'positions'
               link_to 'Crear Mesa', new_board_path, class: 'nav-link', remote: true
             else
               link_to 'Mesas', positions_boards_path, class: 'nav-link'
             end
    content_tag(:li, button, class: 'nav-item')
  end
end
