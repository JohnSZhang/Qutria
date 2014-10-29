Qutria.Views.UserShow = Qutria.Views.Composite.extend({
  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.model.fetch();
  }
  , template: JST['user_show']
  , events: {
    "click button#delete-user" : "deleteUser"
  }
  , deleteUser: function (event) {
    event.preventDefault();
    Qutria.currentUser.destroy({
      success: function () {
        Qutria.currentUser.clear();
        Backbone.history.navigate("", { trigger: true });
      }
    });
  }
  , render: function () {
    this.$el.html(this.template({ user: this.model }));
    return this;
  }
});
