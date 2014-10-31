Qutria.Views.Header = Backbone.View.extend({
  initialize: function (options) {
    this.listenTo(Qutria.currentUser, "change sync reset", this.render);
  }
  , events: {
    "click a#sign-out" : "logout"
  }
  , template: JST['header']
  , className: "header"
  , logout: function (event) {
    event.preventDefault()
    $.ajax({
        url: "/api/session/"
        , type: "DELETE"
        , cache: false
        , success: function (resp) {
          Qutria.currentUser.clear()
        }
        , error: function (resp) {
          console.log("cannot log out")
        }
    });
  }
  , render: function () {
    this.$el = $(this.template());
    return this;
  }
})
