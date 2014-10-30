Qutria.Views.TagsIndex = Qutria.Views.Composite.extend({
  initialize: function () {
    this.listenTo(this.collection, "sync change destroy", this.render);
    this.collection.fetch();
  }
  , template: JST['tag_index']
  , render: function () {
    var self = this;
    this.$el.html(this.template({ tags: this.collection }));
    if (Qutria.currentUser.get('id')) {
      var view = new Qutria.Views.TagCreate({ collection : self.collection });
      self.add_subview('div.new-tag', view);
    }
    return this;
  }
})
