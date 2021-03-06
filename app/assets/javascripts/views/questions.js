Qutria.Views.Questions = Qutria.Views.Composite.extend({
  initialize: function () {
    var self = this;
    this.listenTo(this.collection, "sync reset", this.render);
    this.listenTo(Qutria.currentUser, "change", this.render);
    Qutria.current_page = 1;
    $(window).scroll(_.throttle(this.scrolling.bind(self),
        2500,
        {leading: false}
      ));
    this.collection.fetch({
      data: { page: Qutria.current_page,
              sort: 'title asc'}
    });
    Qutria.scroll_trigger = $(document).height() - $(window).height();
    this.sort_criteria = "id asc";
  }
  , className: "row"
  , template: JST['questions_index']
  , events: {
      'click #sort-newest' : 'questionSort'
      , 'click #sort-popular' : 'questionSort'
      , 'click #sort-name' : 'questionSort'
      , 'click #filter-month' : 'questionFilter'
      , 'click #filter-year' : 'questionFilter'
  }
  , questionFilter: function (event) {
    Qutria.current_page = 1;
    event.preventDefault()
    this.filter_criteria = $(event.currentTarget).data('filter')
    this.collection.fetch({
      data: { page: Qutria.current_page
              , filter: this.filter_criteria
            }
    });
  }
  , questionSort: function (event) {
    Qutria.current_page = 1;
    event.preventDefault()
    var sort_criteria = $(event.currentTarget).data('sort')
    this.collection.fetch({
      data: { page: Qutria.current_page
              , sort: sort_criteria
            }
    });
  }
  , scrolling: function (event) {
    // If we almost scroll to bottom
    if ($(window).scrollTop() >= Qutria.scroll_trigger * .9
      && Qutria.current_page < this.collection.max_pages ) {
        this.collection.fetch({
          remove: false
          , data: { page: Qutria.current_page + 1
            , filter: this.filter_criteria
            , sort: this.sort_criteria }
          , success: function (resp) {
            Qutria.current_page += 1;
            Qutria.scroll_trigger = $(document).height() - $(window).height();
          }
        });
      }
    }
  , render: function () {
    var self= this;
    this.$el.html(this.template({ questions: this.collection }));
    this.collection.each(function (question) {
      var view = new Qutria.Views.QuestionSingle({model : question});
      self.add_subview('ul.questions', view);
    })
    Qutria.scroll_trigger = $(document).height() - $(window).height();
    return this;
  }
})
