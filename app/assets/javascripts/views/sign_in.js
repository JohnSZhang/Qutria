Qutria.Views.SignIn = Qutria.Views.Composite.extend({
  template: JST['sign_in']
  , events: {
    "click button#sign-in": "signIn"
  }
  , signIn: function (event) {
    event.preventDefault()
    var user = $("#sign-in-form").serializeJSON();
    $.ajax({
        url: "/api/session/"
        , type: "POST"
        , data: user
        , success: function (resp) {
          Qutria.currentUser.set(resp);
          Qutria.modalToggle();
          Backbone.history.navigate("", { trigger: true})
        }
        , error: function (resp) {
        }
    });
  }
})
