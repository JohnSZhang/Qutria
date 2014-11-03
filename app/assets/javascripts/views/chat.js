Qutria.Views.Chat = Qutria.Views.Composite.extend({
  initialize: function (options) {
  }
  , className: "chat slider"
  , template: JST['chat']
  , events: {
    "click #send-chat": "sendChat"
  }
  , sendChat: function () {
    $.ajax({
      url: "/api/chat/main/"
      , type: "POST"
      , data: {"message": $("#new-message").val() }
      , success: function () {
        $("#new-message").val("");
      }
    })
  }
  , render: function () {
    this.$el.html(this.template());
    return this;
  }
});
