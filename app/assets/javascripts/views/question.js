Qutria.Views.Question = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.model, "sync change", this.render);
    this.model.fetch();
  }
  , template: JST['question']
  , events: {
    "click #update-question" : "questionUpdate"
    , "click #delete-question" : "questionDelete"
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
  , render: function () {
    this.$el.html(this.template({ question: this.model }));
    return this;
  }
})
