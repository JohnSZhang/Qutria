Qutria.Views.TagCreate = Backbone.View.extend({
  template: JST['tag_create']
  , events: {
    "click button.create-tag" : "tagCreate"
  }
  , tagCreate: function (event) {
    event.preventDefault();
    var self = this;
    var form = this.$('form.create-tag').serializeJSON();
    var newTag = new Qutria.Models.Tag();
    newTag.save(form, {
      success: function () {
        self.collection.add(newTag)
      }
      , error: function () {

      }
    })
  }
  , render: function () {
    var self = this;
    this.$el.html(this.template());
    return this
  }
})
