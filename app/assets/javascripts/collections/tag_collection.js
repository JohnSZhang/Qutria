Qutria.Collections.Tags = Backbone.Collection.extend({
  url: "/api/tags"
  , model: Qutria.Models.Tag
  , parse: function (resp) {
    this.max_pages = resp['pages'];
    delete resp['pages']
    return resp['tags']
  }
})
