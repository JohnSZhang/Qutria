Qutria.Views.SignIn = Qutria.Views.Composite.extend({
  template: JST['sign_in']
  , events: {
    "click button#sign-in": "signIn"
  }
  , signIn: function (event) {
    event.preventDefault()
    var user = $("#sign-in-form").serializeJSON()
    var session = new Qutria.Models.Session(user);
    session.save( {}, {
      success: function (obj) {
        console.log(obj.toJSON())
        Qutria.currentUser = new Qutria.Models.User(obj)
        console.log(Qutria.currentUser.toJSON())
      }
      , error: function (msg) {
        console.log(msg)
      }
    })
  }
})
