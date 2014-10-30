Qutria.Views.NewComment = Qutria.Views.Composite.extend({
  initialize: function (options) {
    this.obj_type = options.obj_type;
  }
  , events: {
    "click button.add-comment": "addComment"
  }
  , addComment: function (event) {
    event.preventDefault();
    var self = this;
    var data = this.$("form.comment-form").serializeJSON();
    var newComment = new Qutria.Models.Comment(data);
    newComment.save({}, {
      success: function (obj) {
        self.model.fetch();
      }
    });
  }
  , template: JST["comment_new"]
  , render: function () {
    this.$el.html(this.template({ obj: this.model, obj_type: this.obj_type }));
  }
});
