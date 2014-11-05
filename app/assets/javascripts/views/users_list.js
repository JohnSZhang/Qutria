Qutria.Views.UsersList = Qutria.Views.Composite.extend({
  initialize: function () {
    this.listenTo(this.collection, "sync change destroy", this.render);
  }
  , template: JST['users_list']
  , render: function () {
    this.$el.html(this.template({ users: this.collection }));
    return this
  }
});
