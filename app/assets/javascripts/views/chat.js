Qutria.Views.Chat = Qutria.Views.Composite.extend({
  initialize: function (options) {
  }
  , className: "chat slider"
  , template: JST['chat']
  , events: {
    "click #send-chat": "sendChat"
    , "click #update-channel": "changeRoomByInput"
    , "keyup #change-channel": "search"
    , "click .chat-search-result": "changeRoomByClick"
  }
  , initChat: function () {
    Qutria.currentChannel = Qutria.chat.subscribe('main');
    Qutria.currentChannel.bind('server-message', function(data) {
      $('#board').append("<li>" + data.message + "</li>")
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
  , search: function (event) {
    $.ajax({
      url: "/api/tags/search/"
      , data: { "query" : $(event.currentTarget).val() }
      , type: "POST"
      , success: function (resp) {
        var container = $('#chat-search-results');
        console.log(resp)
        if (resp.length !== 0) {
          container.removeClass("hide")
        } else {
          container.addClass("hide")
        }
        container.empty();
        resp.forEach(function (tag) {
          var item = "<li class='chat-search-result' data-name='"
            + tag.name + "'>" + tag.name + "</li>";
          container.append(item)
        });
      }
    })
  }
  , getHistory: function () {
    $('#board').empty();
    $.ajax({
      url: "/api/chats/" + Qutria.currentChannel.name
      , type: "GET"
      , success: function (resp) {
          resp.forEach(function (chat) {
            $('#board').append(
              "<li>" + chat.user + ":" + chat.message + "</li>")
          })
      }
    })
  }
  , changeRoomByClick: function (event) {
    var newRoom = $(event.currentTarget).data("name");
    this.changeRoom(newRoom);
  }
  , changeRoomByInput: function (event) {
    var newRoom = $('#change-channel').val();
    if (newRoom !== "") {
      this.changeRoom(newRoom);
    }
  }
  , changeRoom: function (roomId) {
    Qutria.currentChannel.unsubscribe();
    Qutria.currentChannel = Qutria.chat.subscribe(roomId);
    Qutria.currentChannel.bind('server-message', function(data) {
      $('#board').append("<li>" + data.message + "</li>")
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
