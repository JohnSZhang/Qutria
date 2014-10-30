Qutria.Views.Tag = Qutria.Views.Composite.extend({
  initialize: function () {
    this.listenTo(this.model, "sync change", this.render);
  }
  , template: JST['tag']
  , render: function () {
    var self = this;
    this.$el.html(this.template({ tag: this.model }));
    return this;
  }
});
