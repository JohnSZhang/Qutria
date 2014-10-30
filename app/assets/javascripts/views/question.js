Qutria.Views.Question = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.model, "sync change", this.render);
    this.model.fetch();
  }
  , template: JST['question']
  , events: {
  }
  , render: function () {
    this.$el.html(this.template({ question: this.model }));
    return this;
  }
})
