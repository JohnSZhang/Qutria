Qutria.Views.Users = Qutria.Views.Composite.extend({
  initialize: function () {
    this.listenTo(this.collection, "sync", this.render)
  }
  , template: JST['users_index']
  , render: function () {
    this.$el.html(this.template({ users: this.collection}));
    return this;
  }
})
