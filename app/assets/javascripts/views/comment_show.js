Qutria.Views.Comment = Qutria.Views.Composite.extend({
  initialize: function () {
    this.listenTo(this.model, "sync change", this.render);
  }
  , template: JST['comment']
  , render: function () {
    var self = this;
    this.$el.html(this.template({ comment: this.model }));
    if (this.model.user) {
        var view = new Qutria.Views.Author({ model: this.model.user })
        self.add_subview("div.author", view)
    }
    return this;
  }
});
