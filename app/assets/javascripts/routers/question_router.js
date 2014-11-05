Qutria.Routers.Question = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.$main = this.$rootEl.find('main');
    this.$header = this.$rootEl.find('header');
    this.$footer = this.$rootEl.find('footer');
  }
  , routes: {
    "questions" : "questions"
    , "questions/:id" : "question"
    , "favorites" : "favorites"
    , "unanswered" : "unanswered"
  }
  , questions: function () {
    var questions = new Qutria.Collections.Questions();
    var view = new Qutria.Views.Questions({ collection: questions });
    this._swapView({
      "$main": view
    });
  }
  , question: function (id) {
    var question = new Qutria.Models.Question({ id :id });
    var view = new Qutria.Views.Question({ model: question });
    this._swapView({
      "$main": view
    });
  }
  , favorites: function () {
    var favorite = new Qutria.Models.Favorite();
    var view = new Qutria.Views.Favorites({ model: favorite})
    this._swapView({
      "$main": view
    });
  }
  , unanswered: function () {
    var questions = new Qutria.Collections.UnansweredQuestions();
    var view = new Qutria.Views.Questions({ collection: questions });
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
