Qutria.Views.Favorites = Qutria.Views.Composite.extend({
  initialize: function () {
    var self = this;
    this.listenTo(this.model, "sync change destroy", this.render);
    this.listenTo(Qutria.global, "tagging", function () {
      self.model.fetch();
    })
    this.model.fetch();
  }
  , template: JST['favorite_questions']
  , render: function () {
    var self = this;
    this.$el.html(this.template({ favorites: self.model }));
    if (this.model.favorite_tags) {
      this.model.favorite_tags.each(function (tag) {
        var view = new Qutria.Views.TagShow({
          model : tag,
          collection: self.model.favorite_tags})
        self.add_subview(".tags", view)
      })
    }
    if (this.model.favorite_tag_questions) {
      this.model.favorite_tag_questions.each(function (question) {
        var view = new Qutria.Views.QuestionSingle({model : question})
        self.add_subview(".questions", view)
      })
    }
    return this
  }
})
