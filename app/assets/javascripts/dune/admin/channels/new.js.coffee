Neighborly.Neighborly ?= {}
Neighborly.Neighborly.Admin ?= {}
Neighborly.Neighborly.Admin.Channels ?= {}

Neighborly.Neighborly.Admin.Channels.New =
  init: Backbone.View.extend
    el: '.admin'

    initialize: ->
      this.$('.markdown-editor').markItUp(Neighborly.markdownSettings)


Neighborly.Neighborly.Admin.Channels.Edit =
  modules: -> [Neighborly.Neighborly.Admin.Channels.New]
