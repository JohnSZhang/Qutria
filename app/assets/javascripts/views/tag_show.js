Qutria.Views.TagShow = Qutria.Views.Composite.extend({
  initialize: function () {
    this.listenTo(this.model, "sync change destroy", this.render);
    this.model.fetch();
  }
  , template: JST['tag_show']
  , render: function () {
    var self = this;
    this.$el.html(this.template({ tag: this.model }));
    if (Qutria.currentUser.get('id')) {
        var view = new Qutria.Views.TagEdit({ model: this.model })
        self.add_subview("div.tag-edit", view)
    }
    if (this.model.questions) {
      this.model.questions.each(function (question) {
        var view = new Qutria.Views.QuestionSingle({ model: question })
        self.add_subview("div.tag-questions", view)
      })
    }
    return this
  }
})
