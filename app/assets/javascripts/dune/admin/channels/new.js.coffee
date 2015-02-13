Dune.Dune ?= {}
Dune.Dune.Admin ?= {}
Dune.Dune.Admin.Channels ?= {}

Dune.Dune.Admin.Channels.New =
  init: Backbone.View.extend
    el: '.admin'

    initialize: ->
      this.$('.markdown-editor').markItUp(Dune.markdownSettings)


Dune.Dune.Admin.Channels.Edit =
  modules: -> [Dune.Dune.Admin.Channels.New]
