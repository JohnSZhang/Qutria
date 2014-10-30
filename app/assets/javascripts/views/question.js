Qutria.Views.Question = Qutria.Views.Composite.extend({
  initialize: function () {
    this.listenTo(this.model, "sync change", this.render);
    this.model.fetch();
  }
  , template: JST['question']
  , events: {
    "click #update-question" : "questionUpdate"
    , "click #delete-question" : "questionDelete"
    , "click button#answer-question": "answerCreate"
  }
  , questionUpdate: function (event) {
    event.preventDefault();
    var form = $('#edit-form').serializeJSON();
    this.model.save(form, {
      success: function () {

      }
      , error: function () {

      }
    })
  }
  , questionDelete: function (event) {
    event.preventDefault();
    this.model.destroy({
      success: function () {
        Backbone.history.navigate("questions", { trigger: true })
      }
      , error: function () {

      }
    })
  }
  , answerCreate: function (event) {
    event.preventDefault()
    var self = this;
    var data = $("#answer-form").serializeJSON();
    var newAnswer = new Qutria.Models.Answer(data);
    newAnswer.save({}, {
      success: function (obj) {
        self.model.answers.add(newAnswer)
      }
    });
  }
  , render: function () {
    var self = this;
    this.$el.html(this.template({ question: this.model }));
    if(this.model.answers) {
      this.model.answers.each(function (answer) {
        var view = new Qutria.Views.Answer({ model: answer })
        self.add_subview("div.answers", view)
      })
    }
    if(this.model.comments) {
      this.model.comments.each(function (comment) {
        var view = new Qutria.Views.Comment({ model: comment })
        self.add_subview("div.question-comments", view)
      })
    }
    if (this.model.user) {
        var view = new Qutria.Views.Author({ model: this.model.user })
        self.add_subview("div.question-author", view)
    }
    return this;
  }
})
