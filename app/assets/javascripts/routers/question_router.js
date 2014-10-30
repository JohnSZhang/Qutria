Qutria.Routers.Question = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.$main = this.$rootEl.find('main');
  }
  , routes: {
    "questions" : "questions"
  }
  , questions: function () {
    var questions = new Qutria.Collections.Questions();
    var view = new Qutria.Views.Questions({ collection: questions});
    this._swapView({
      "$main": view
    });
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
