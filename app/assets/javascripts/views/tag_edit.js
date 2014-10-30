Qutria.Views.TagEdit = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.model, "sync change destroy", this.render);
  }
  , template: JST['tag_edit']
  , events: {
    "click button.edit-tag" : "tagUpdate"
  }
  , tagUpdate: function (event) {
    event.preventDefault();
    var form = this.$('form.edit-tag').serializeJSON();
    this.model.save(form, {
      success: function () {

      }
      , error: function () {

      }
    })
  }
  , render: function () {
    var self = this;
    this.$el.html(this.template({ tag: this.model }));
    return this
  }
})
