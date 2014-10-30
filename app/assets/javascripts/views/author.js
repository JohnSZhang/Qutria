Qutria.Views.Author = Qutria.Views.Composite.extend({
  initialize: function () {
    this.listenTo(this.model, "sync change", this.render);
  }
  , template: JST['author']
  , render: function () {
    var self = this;
    this.$el.html(this.template({ author: this.model }));
    return this;
  }
});
