Qutria.Views.Composite = Backbone.View.extend({
  add_subview: function (selector, subview) {
    this.subviews(selector).push(subview.render());
    this.$(selector).append(subview.$el);
    subview.delegateEvents();
  }
  , remove_subview: function (selector, subview) {
    subview.remove()
    var index = this.subviews(selector).indexOf(subview)
    this.subviews(selector).slice(index, 1);
  }
  , remove: function () {
    Backbone.View.prototype.remove.call(this);
    _(this.subviews()).each(function (subviews) {
      _(subviews).each(function (subview) {
        subview.remove();
      })
    })
  }
  , subviews: function (selector) {
    this._subviews = this._subviews || {};
    if(selector) {
      this._subviews[selector] = this._subviews[selector] || [] ;
      return this._subviews[selector]
    } else {
      return this._subviews;
    }
  }
  , render: function () {
    this.$el.html(this.template());
    return this;
  }
})
