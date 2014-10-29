Qutria.Routers.router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.$header = this.$rootEl.find('header');
    this.$footer = this.$rootEl.find('footer');
    this.$main = this.$rootEl.find('main');
  }

  , routes: {
    "" : "index"
    , "users": "users"
    , "signup" : "signup"
  }

  , index: function () {
    var headerView = new Qutria.Views.StaticHeader();
    var footerView = new Qutria.Views.StaticFooter();
    var mainView = new Qutria.Views.StaticBody();
    this._swapView({
      "$header": headerView
      , "$footer": footerView
      , "$main" : mainView
      });
  }

  , users: function () {
    var view = new Qutria.Views.User();
    this._swapView(view);
  }

  , _swapView: function (options) {
    for (var view in options) {
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
