Qutria.Views.User = Qutria.Views.Composite.extend({
  template: JST['user']
  , render: function () {
    this.$el.html(this.template());
    return this;
  }
})
