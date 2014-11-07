Qutria.Views.TagShow = Qutria.Views.Composite.extend({
  initialize: function () {
    this.listenTo(this.model, "sync change destroy", this.render);
    this.model.fetch();
  }
  , events: {
    "click #favorite-toggle" : "toggleFavorite"
  }
  , template: JST['tag_show']
  , toggleFavorite: function (event) {
    event.preventDefault();
    var self = this;
    if (this.model.get('favorite')) {
      $.ajax({
        url: "/api/tags/" + this.model.get('id') + "/favorite"
        , type: "DELETE"
        , cache: false
        , success: function (resp) {
          self.model.fetch();
          Qutria.global.trigger('tagging');
        }
        , error: function (resp) {
        }
      });
    } else {
      $.ajax({
        url: "/api/tags/" + this.model.get('id') + "/favorite"
        , type: "POST"
        , cache: false
        , success: function (resp) {
          self.model.fetch();
          Qutria.global.trigger('tagging');
        }
        , error: function (resp) {
        }
      });
    }
  }
  , render: function () {
    var self = this;
    this.$el.html(this.template({ tag: this.model }));
    if (Qutria.currentUser.get('id')) {
      var view = new Qutria.Views.TagEdit({ model: this.model })
      self.add_subview("div.tag-edit", view)
    }
    if (this.model.questions && !this.collection) {
      this.model.questions.each(function (question) {
        var view = new Qutria.Views.QuestionSingle({ model: question })
        self.add_subview("ul.tag-questions", view)
      })
    }
    return this
  }
})
