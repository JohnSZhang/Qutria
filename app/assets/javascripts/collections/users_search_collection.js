Qutria.Collections.UsersSearch = Backbone.Collection.extend({
  model: Qutria.Models.User
  , url: "/api/users/search"
  , parse: function (resp) {
    this.max_pages = resp['pages'];
    delete resp['pages']
    return resp['users']
  }
})
