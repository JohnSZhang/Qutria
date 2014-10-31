Qutria.Views.Votes = Qutria.Views.Composite.extend({
  initialize: function () {
    this.listenTo(this.model, "sync change", this.render);
  }
  , events: {
    "click button.upvote" : "upvote"
    , "click button.downvote" : "downvote"
  }
  , upvote: function (event) {
    event.preventDefault();
    this.model.upvote();
  }
  , downvote: function (event) {
    event.preventDefault();
    this.model.downvote();
  }
  , template: JST['vote']
  , render: function () {
    var self = this;
    this.$el.html(this.template({ obj: this.model }));
    return self;
  }
});
