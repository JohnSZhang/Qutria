Qutria.Views.Answer = Qutria.Views.Composite.extend({
  initialize: function () {
    this.listenTo(this.model, "sync change", this.render);
  }
  , template: JST['answer']
  , render: function () {
    var self = this;
    this.$el.html(this.template({ answer: this.model }));
    if(this.model.comments) {
      this.model.comments.each(function (comment) {
        var view = new Qutria.Views.Comment({ model: comment })
        self.add_subview("div.answer-comments", view)
      })
    }
    if (this.model.user) {
        var view = new Qutria.Views.Author({ model: this.model.user })
        self.add_subview("div.answer-author", view)
    }
    return this;
  }
});
