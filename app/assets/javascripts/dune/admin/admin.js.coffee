Dune.Dune ?= {}
Dune.Dune.Admin ?= {}

Dune.Dune.Admin.modules =-> [Dune.Dune.Admin.Common,
                                         Dune.Dune.Admin.Modules.Sort]

Dune.Dune.Admin.Common = Backbone.View.extend
  el: '.admin'

  initialize: ->
    $('.best_in_place').best_in_place()
