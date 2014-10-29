window.Qutria = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var $rootEl = $('body');
    var self = this;
    Qutria.currentUser = new self.Models.User();
    $.ajax({
        url: "/api/session/current"
        , dataType: "json"
        , cache: false
        , success: function (resp) {
            Qutria.currentUser.set(resp);
        }
        , error: function (resp) {
          console.log('something went wrong')
        }
    });
    new this.Routers.router({$rootEl: $rootEl});
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Qutria.initialize();
});
