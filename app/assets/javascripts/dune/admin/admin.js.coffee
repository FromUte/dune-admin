Neighborly.Neighborly ?= {}
Neighborly.Neighborly.Admin ?= {}

Neighborly.Neighborly.Admin.modules =-> [Neighborly.Neighborly.Admin.Common,
                                         Neighborly.Neighborly.Admin.Modules.Sort]

Neighborly.Neighborly.Admin.Common = Backbone.View.extend
  el: '.admin'

  initialize: ->
    $('.best_in_place').best_in_place()
