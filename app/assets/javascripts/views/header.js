Qutria.Views.Header = Qutria.Views.Composite.extend({
  initialize: function (options) {
    this.listenTo(Qutria.currentUser, "change sync reset", this.getNotification);
  }
  , className: "header row"
  , events: {
    "click a#sign-out" : "logout"
    , "keyup #top-search" : "search"
    , "click .search-result": "linkTo"
    , "click .notification": "readNotification"
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
        self.render();
      }
    })
    if (Qutria.currentUser.has('id') && !Qutria.notificationChannel) {
      self.bindChannel();
    }
  }
  , bindChannel: function () {
    var self = this;
    Qutria.notificationChannel =
        Qutria.chat.subscribe('user_' + Qutria.currentUser.get('id'));
    Qutria.notificationChannel.bind('notification', function(data) {
      self.getNotification();
    });
  }
  , readNotification: function (event) {
    $('#message-list').toggle();
    var self = this;
    var id = $(event.currentTarget).data('id');
    var notification = new Qutria.Models.Notification({ id: id });
  notification.read(
    {
      success: function () {
        self.getNotification();
      }
    });
  }
  , logout: function (event) {
    event.preventDefault();
    var self = this;
    $.ajax({
        url: "/api/session/"
        , type: "DELETE"
        , cache: false
        , success: function (resp) {
          Qutria.currentUser.clear()
          self.render()
        }
        , error: function (resp) {
          console.log("cannot log out")
        }
    });
  }
  , render: function () {
    this.$el.html(this.template());
    var signIn = new Qutria.Views.SignIn()
    this.add_subview( "#sign-in", signIn);

    var signUp = new Qutria.Views.SignUp()
    this.add_subview( "#sign-up", signUp);
    return this;
  }
})
