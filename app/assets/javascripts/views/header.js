Qutria.Views.Header = Backbone.View.extend({
  template: JST['header']
  , className: "header"
  , render: function () {
    this.$el.html(this.template());
    return this;
  }
})
