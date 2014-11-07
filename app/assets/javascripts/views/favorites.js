Qutria.Views.Favorites = Qutria.Views.Composite.extend({
  initialize: function () {
    var self = this;
    this.listenTo(this.model, "sync change destroy", this.render);
    Qutria.current_page = 1;
    this.listenTo(Qutria.global, "tagging", function () {
      self.model.fetch({
        data: {page: Qutria.current_page}
      });
    })
    this.model.fetch({
        data: {page: Qutria.current_page}
    });
    $(window).scroll(_.throttle(this.scrolling.bind(self),
        2500,
        {leading: false}
      ));
  }
  , template: JST['favorite_questions']
  , scrolling: function (event) {
    if (!Qutria.scroll_trigger) {
      Qutria.scroll_trigger = $(document).height() - $(window).height();
    }
  // If we almost scroll to bottom
  if ($(window).scrollTop() >= Qutria.scroll_trigger * .9
    && Qutria.current_page < this.model.max_pages ) {
      this.model.fetch({
        remove: false
        , data: { page: Qutria.current_page + 1}
        , success: function (resp) {
          Qutria.current_page += 1;
          Qutria.scroll_trigger = $(document).height() - $(window).height();
        }
      });
    }
  }
  , render: function () {
    var self = this;
    this.$el.html(this.template({ favorites: self.model }));
    if (this.model.favorite_tags) {
      this.model.favorite_tags.each(function (tag) {
        var view = new Qutria.Views.TagShow({
          model : tag,
          collection: self.model.favorite_tags})
        self.add_subview(".tags", view)
      })
    }
    if (this.model.favorite_tag_questions) {
      this.model.favorite_tag_questions.each(function (question) {
        var view = new Qutria.Views.QuestionSingle({model : question})
        self.add_subview(".questions", view)
      })
    }
    return this
  }
})
