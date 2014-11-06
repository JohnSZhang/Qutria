Qutria.Views.Header = Backbone.View.extend({
  initialize: function (options) {
    this.listenTo(Qutria.currentUser, "change sync reset", this.getNotification);
  }
  , className: "header row"
  , events: {
    "click a#sign-out" : "logout"
    , "keyup #top-search" : "search"
    , "click .search-result": "linkTo"
  }
  , template: JST['header']
  , className: "header"
  , search: function (event) {
    $.ajax({
      url: "/api/search"
      , data: { "query" : $(event.currentTarget).val() }
      , type: "POST"
      , success: function (resp) {
        var container = $('#top-search-results');
        if (resp.length !== 0) {
          container.removeClass("hide")
        } else {
          container.addClass("hide")
        }
        container.empty();
        resp.forEach(function (result) {
          var item = "<li class='search-result' data-link='" + result.link + "'>"
            + result.searchable_type + ": " + result.content + "</li>";
          container.append(item)
        });
      }
    })
  }
  , linkTo: function (event) {
    var link = $(event.currentTarget).data("link");
    Backbone.history.navigate(link, {trigger: true});
    $('#top-search-results').empty;
  }
  , getNotification: function () {
    var self = this;
    Qutria.currentUserNotifications = new Qutria.Collections.Notifications()
    Qutria.currentUserNotifications.fetch({
      success: function (resp) {
        console.log(Qutria.currentUserNotifications)
        self.render();
      }
    })
    if (Qutria.currentUser.has('id')) {
      Qutria.notificationChannel =
          Qutria.chat.subscribe('user_' + Qutria.currentUser.get('id'));
      Qutria.notificationChannel.bind('notification', function(data) {
        console.log('new notification!')
      });
    }
  }
  , logout: function (event) {
    event.preventDefault();
    $.ajax({
        url: "/api/session/"
        , type: "DELETE"
        , cache: false
        , success: function (resp) {
          Qutria.currentUser.clear()
        }
        , error: function (resp) {
          console.log("cannot log out")
        }
    });
  }
  , render: function () {
    this.$el.html(this.template());
    return this;
  }
})
