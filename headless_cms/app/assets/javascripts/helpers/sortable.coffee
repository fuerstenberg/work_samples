class CMS.Helpers.Sortable

  constructor: ->
    if element = $('[data-sortable]')
      url = element.data('sortable')
      element.sortable
        axis: 'y'
        items: 'a'
        update: (event, ui) =>
          data = $('[data-sortable]').sortable 'serialize',
            key: 'sortable_ids[]'
          $.post url, data
