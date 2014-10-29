Qutria.Views.SignUp = Qutria.Views.Composite.extend({
  template: JST['sign_up']
  , events: {
    "click button#new-user": "signUp"
  }
  , signUp: function (event) {
    event.preventDefault()
    var data = $("#sign-up-form").serializeJSON();
    var newUser = new Qutria.Models.User(data);
    newUser.save({}, {
      success: function (obj) {
        Qutria.currentUser.set("id", obj.id); 
        Backbone.history.navigate("", { trigger: true });
      }
    });
  }
})
