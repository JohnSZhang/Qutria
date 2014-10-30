Qutria.Views.Questions = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.collection, "sync add remove reset", this.render);
    this.listenTo(Qutria.currentUser, "change", this.render);
    this.collection.fetch();
  }
  , template: JST['questions_index']
  , events: {
      "click #new-question" : "questionCreate"
  }
  , questionCreate: function (event) {
    event.preventDefault();
    var self = this;
    var form = $('#new-question-form').serializeJSON();
    var newQuestion = new Qutria.Models.Question(form);
    newQuestion.set("user", Qutria.currentUser);
    newQuestion.save({}, {
      success: function () {
        self.collection.add(newQuestion)
      }
      , error: function () {
      }
    })
  }
  , render: function () {
    this.$el.html(this.template({ questions: this.collection }));
    return this;
  }
})
