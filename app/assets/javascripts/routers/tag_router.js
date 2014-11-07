Qutria.Routers.Tag = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.$main = this.$rootEl.find('#main');
  }
  , routes: {
    "tags" : "tags"
    , "tags/:id" : "tag"
  }
  , tags: function () {
    var tags = new Qutria.Collections.Tags();
    var view = new Qutria.Views.TagsIndex({ collection: tags });
    this._swapView({
      "$main": view
    });
  }
  , tag: function (id) {
    var tag = new Qutria.Models.Tag({ id :id });
    var view = new Qutria.Views.TagShow({ model: tag });
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
