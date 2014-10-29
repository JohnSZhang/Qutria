Qutria.Models.Session = Backbone.Model.extend({
  urlRoot: "/api/session"
  , signOut: function () {
    $.ajax({
      url: '/api/session'
      , type: "delete"
      , success: function (resp) {
        Qutria.currentUser.clear()
      }
      , error: function (resp) {
        console.log('cannot log out')
      }
    })
  }
})
