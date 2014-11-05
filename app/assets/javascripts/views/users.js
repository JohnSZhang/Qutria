Qutria.Views.Users = Qutria.Views.Composite.extend({
  initialize: function () {
    this.listenTo(this.collection, "sync", this.render)
    Qutria.current_page = 1;
    this.collection.fetch({
      data: { page: Qutria.current_page }
    });
  }
  , events: {
    "keyup #find-user" : "search"
  }
  , template: JST['users_index']
  , search: function (event) {
    var self = this;
    var query = $(event.currentTarget).val();
    this.query = query;
    var newCollection = new Qutria.Collections.UsersSearch()
    newCollection.fetch({
      data: { query: this.query }
      , success: function (resp) {
        self.remove_subview('div#users', self.currentUsers);
        self.currentUsers = new Qutria.Views.UsersList({ collection: newCollection});
        self.add_subview('div#users', self.currentUsers);
      }
    })
  }
  , render: function () {
    var query = this.query ? this.query : "";
    var self = this;
    this.$el.html(this.template({ search: query }));

    this.currentUsers = new Qutria.Views.UsersList({ collection: self.collection })
    self.add_subview('div#users', this.currentUsers);

    return this;
  }
})
