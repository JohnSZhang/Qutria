Qutria.Routers.router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.$header = this.$rootEl.find('header');
    this.$footer = this.$rootEl.find('footer');
    this.$main = this.$rootEl.find('#main');
    this.$chat = this.$rootEl.find('#chat');
    this.init();
  }
  , routes: {
    "" : "index"
    , "users" : "users"
    , "sign-in" : "signIn"
    , "sign-up" : "signUp"
    , "users/:id" : "userShow"
  }
  , init: function () {
    var headerView = new Qutria.Views.Header();
    var footerView = new Qutria.Views.Footer();
    var chatView = new Qutria.Views.Chat();
    this._swapView({
      "$header": headerView
      , "$footer": footerView
      , "$chat": chatView
      });
  }
  , index: function () {
    var collection = new Qutria.Collections.Questions();
    var mainView = new Qutria.Views.Questions({ collection: collection});
    this._swapView({
        "$main" : mainView
      });
  }
  , signIn: function () {
    var view = new Qutria.Views.SignIn();
    this._swapView({
      "$main": view
    });
  }
  , signUp: function () {
    var view = new Qutria.Views.SignUp();
    this._swapView({
      "$main": view
    });
  }
  , userShow: function (id) {
    var user = new Qutria.Models.User({ id: id });
    var view = new Qutria.Views.UserShow({ model : user});
    this._swapView({
      "$main": view
    });
  }
  , users: function () {
    var users = new Qutria.Collections.Users();
    users.fetch();
    var view = new Qutria.Views.Users({
      collection: users
    });
    this._swapView({
      "$main": view
    });
  }
  , _swapView: function (options) {
    for (var view in options) {
      if (view === "$main") {
        options[view].$el.addClass("row")
        options[view].className = "row";
      }
      this._swapSingleView(options[view], view)
    }
  }
  , _swapSingleView: function (singleView, element) {
      // Define or add a hidden view for this section, then render
      this["_" + element] && this["_" + element].remove();
      this["_" + element] = singleView;
      this[element].html(singleView.render().$el);
  }
})
