Qutria.Views.Tag = Qutria.Views.Composite.extend({
  initialize: function (options) {
    this.listenTo(this.model, "sync change", this.render);
    this.taggings = options.taggings;
    this.taggings_type = options.taggings_type;
    this.model.fetch();
  }
  , tagName: "span"
  , template: JST['tag']
  , events: {
    "click .untag" : "untag"
  }
  , untag: function (event) {
    var self = this;
    event.preventDefault();
    var form = this.$('.taggable-destroy').serializeJSON();
    $.ajax({
      url: "/api/taggables"
      , type: "delete"
      , cache: false
      , data: form
      , success: function (resp) {
        self.$el.empty();
      }
      , error: function (resp) {
      }
    });
  }
  , render: function () {
    var self = this;
    this.$el.html(this.template({
      tag: this.model
      , taggings: this.taggings
      , taggings_type: this.taggings_type }));
    return this;
  }
});
