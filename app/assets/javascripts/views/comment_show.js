Qutria.Views.Comment = Qutria.Views.Composite.extend({
  initialize: function () {
    this.listenTo(this.model, "sync change destroy", this.render);
  }
  , template: JST['comment']
  , events: {
    "click button.edit-comment" : "updateComment"
    , "click a.delete-comment" : "deleteComment"
  }
  , updateComment: function (event) {
    event.preventDefault();
    var data = this.$(".edit-comment").serializeJSON();
    this.model.save(data, {
      success: function () {
      }
    })
  }
  , deleteComment: function (event) {
    event.preventDefault();
    var self = this;
    this.model.destroy({
      success: function () {
        self.remove()
      }
    })
  }
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
