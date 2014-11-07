Qutria.Views.Questions = Backbone.View.extend({
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
    Qutria.scroll_trigger = $(document).height() - $(window).height()
  }
  , className: "row"
  , template: JST['questions_index']
  , events: {
      "click #new-question" : "questionCreate"
      , 'click #sort-newest' : 'questionSort'
      , 'click #sort-popular' : 'questionSort'
      , 'click #sort-name' : 'questionSort'
      , 'click #filter-month' : 'questionFilter'
      , 'click #filter-year' : 'questionFilter'
  }
  , questionCreate: function (event) {
    event.preventDefault();
    var self = this;
    var form = $('#new-question-form').serializeJSON();
    var newQuestion = new Qutria.Models.Question(form);
    newQuestion.set("user", Qutria.currentUser);
    newQuestion.save({}, {
      success: function () {
        self.collection.add(newQuestion)
      }
      , error: function () {
      }
    })
  }
  , questionFilter: function (event) {
    Qutria.current_page = 1;
    event.preventDefault()
    var sort_criteria = $(event.currentTarget).data('filter')
    this.collection.fetch({
      data: { page: Qutria.current_page,
              filter: sort_criteria}
    });
  }
  , questionSort: function (event) {
    Qutria.current_page = 1;
    event.preventDefault()
    var sort_criteria = $(event.currentTarget).data('sort')
    this.collection.fetch({
      data: { page: Qutria.current_page,
              sort: sort_criteria}
    });
  }
  , scrolling: function (event) {
    // If we almost scroll to bottom
    if ($(window).scrollTop() >= Qutria.scroll_trigger * .9
      && Qutria.current_page < this.collection.max_pages ) {
        this.collection.fetch({
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
    this.$el.html(this.template({ questions: this.collection }));
    console.log('render')
    return this;
  }
})
