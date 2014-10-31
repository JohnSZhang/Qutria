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
            console.log(resp)
            Qutria.currentUser.set(resp);
        }
        , error: function (resp) {
          console.log('something went wrong')
        }
    });
    self.router = new this.Routers.router({$rootEl: $rootEl});
    self.question_router = new this.Routers.Question({$rootEl: $rootEl});
    self.tag_router = new Qutria.Routers.Tag({$rootEl: $rootEl})
    Qutria.global = new Qutria.Models.Global();
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Qutria.initialize();

  $('main').on("click", "a.form-toggle", function (event) {
    event.preventDefault()
    var selector = '#'+ $(event.target).data('selector');
    $(selector).toggle();
  });

});
