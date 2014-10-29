window.Qutria = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var $rootEl = $('body')
    new this.Routers.router({$rootEl: $rootEl});
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Qutria.initialize();
});
