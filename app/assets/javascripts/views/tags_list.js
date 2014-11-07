Qutria.Views.TagsList = Qutria.Views.Composite.extend({
  initialize: function () {
    this.listenTo(this.collection, "sync change destroy", this.render);
  }
  , className: "row"
  , template: JST['tags_list']
  , render: function () {
    this.$el.html(this.template({ tags: this.collection }));
    return this
  }
});
