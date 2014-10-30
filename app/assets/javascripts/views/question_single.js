Qutria.Views.QuestionSingle = Qutria.Views.Composite.extend({
  initialize: function () {
    this.listenTo(this.model, "sync change destroy", this.render);
  }
  , template: JST['question_list_item']
  , render: function () {
    var self = this;
    this.$el.html(this.template({ question: this.model }));
    return this;
  }
});
