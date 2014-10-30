Qutria.Views.Questions = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.collection, "sync add remove reset", this.render);
    this.collection.fetch();
  }
  , template: JST['questions_index']
  , events: {
  }
  , render: function () {
    this.$el.html(this.template({ questions: this.collection }));
    return this;
  }
})
