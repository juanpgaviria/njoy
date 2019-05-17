class SearchSelect
  constructor: () ->
    @initializeSelect()
    if $('.menu-items')
      $('.menu-items').on('cocoon:after-insert', @initializeSelect)

  initializeSelect: () ->
    $('select').select2
      theme: 'bootstrap'

window.SearchSelect = SearchSelect
