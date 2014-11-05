Qutria.Views.TagsIndex = Qutria.Views.Composite.extend({
  initialize: function () {
    this.listenTo(this.collection, "sync change destroy", this.render);
    Qutria.current_page = 1;
    this.collection.fetch({
      data: { page: Qutria.current_page }
    });
  }
  , events: {
    "keyup #find-tag" : "search"
  }
  , template: JST['tag_index']
  , search: function (event) {
    var self = this;
    var query = $(event.currentTarget).val();
    this.query = query;
    var newCollection = new Qutria.Collections.TagsSearch()
    newCollection.fetch({
      data: { query: this.query }
      , success: function (resp) {
        self.remove_subview('div#tags', self.currentTags);
        self.currentTags = new Qutria.Views.TagsList({ collection: newCollection});
        self.add_subview('div#tags', self.currentTags);
      }
    })
  }
  , render: function () {
    var query = this.query ? this.query : "";
    var self = this;
    this.$el.html(this.template({ search: query }));

    this.currentTags = new Qutria.Views.TagsList({ collection: self.collection })
    self.add_subview('div#tags', this.currentTags);

    if (Qutria.currentUser.get('id')) {
      var view = new Qutria.Views.TagCreate({ collection : self.collection });
      self.add_subview('div.new-tag', view);
    }
    return this;
  }
})
