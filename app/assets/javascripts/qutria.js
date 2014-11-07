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
          Qutria.currentUser.set(resp)
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

window.onbeforeunload = function(e) {
    //return "Please, please don't leave, it's cold and dark in here!";
};

$(document).ready(function(){
  Qutria.initialize();
  Qutria.modalToggle = function () {
    $('body').toggleClass('modal-open');
    $('#modal-backdrop').toggle();
  }
  $('#toggle-chat').on("click", function (event) {
    event.preventDefault();
    $('#chat').toggleClass('small-7').toggleClass('right').toggle()
    $('#main').toggleClass('small-5').toggleClass('left')
  });

  $('body').on("click", ".form-toggle", function (event) {
    event.preventDefault()
    var selector = '#'+ $(event.target).data('selector');
    $(selector).toggle();
  });
  $('body').on("click", ".modal-form-toggle", function (event) {
    event.preventDefault()
    console.log('clicked')
    var selector = '#'+ $(event.target).data('selector');
    $(selector).toggle();
    Qutria.modalToggle();
  });
  $('main').on("click", ".filepicker-user", function (event) {
    event.preventDefault()
    filepicker.pick(function (blob) {
      Qutria.currentUser.set("filepicker_url", blob.url);
      Qutria.currentUser.save()
    })
  });
});
