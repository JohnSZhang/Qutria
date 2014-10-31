Qutria.Views.Footer = Backbone.View.extend({
  template: JST['footer']
  , className: "footer"
  , render: function () {
    this.$el = $(this.template());
    return this;
  }
})
