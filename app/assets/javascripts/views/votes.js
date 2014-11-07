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
    if (this.model.has('vote_type') &&  this.model.get('vote_type') === 1) {
      var vote_type = "upvotted"
    } else if (this.model.has('vote_type') &&  this.model.get('vote_type') === -1) {
        var vote_type = "downvotted"
    } else { var vote_type = "none"}
    this.$el.html(this.template({ obj: this.model, vote_type: vote_type }));
    return self;
  }
});
