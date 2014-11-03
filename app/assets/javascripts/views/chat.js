Qutria.Views.Chat = Qutria.Views.Composite.extend({
  initialize: function (options) {
  }
  , className: "chat slider"
  , template: JST['chat']
  , events: {
    "click #send-chat": "sendChat"
    , "click #update-channel": "changeRoom"
  }
  , initChat: function () {
    Qutria.currentChannel = Qutria.chat.subscribe('main');
    Qutria.currentChannel.bind('server-message', function(data) {
      $('#board').append("<p>" + data.message + "</p>")
    });
  }
  , sendChat: function () {

    if (Qutria.currentChannel.name === "main") {
      $.ajax({
        url: "/api/chats/"
        , type: "POST"
        , data: {"message": $("#new-message").val() }
        , success: function () {
          $("#new-message").val("");
        }
      })
    } else {
      $.ajax({
        url: "/api/chats/" + Qutria.currentChannel.name
        , type: "POST"
        , data: {"message": $("#new-message").val() }
        , success: function () {
          $("#new-message").val("");
        }
      })
    }
  }
  , getHistory: function () {
    $('#board').empty();
    $.ajax({
      url: "/api/chats/" + Qutria.currentChannel.name
      , type: "GET"
      , success: function (resp) {
          resp.forEach(function (chat) {
            $('#board').append("<p>" + chat.user + ":" + chat.message + "</p>")
          })
      }
    })
  }
  , changeRoom: function () {
    var newRoom = $('#change-channel').val()
    Qutria.currentChannel.unsubscribe();
    Qutria.currentChannel = Qutria.chat.subscribe(newRoom);
    Qutria.currentChannel.bind('server-message', function(data) {
      $('#board').append("<p>" + data.message + "</p>")
    });
    $('#change-channel').val("")
    this.getHistory();
  }
  , render: function () {
    var self = this;
    this.$el.html(this.template());
    $(function () {
      self.initChat()
    });
    return this;
  }
});
