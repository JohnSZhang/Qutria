Qutria.Models.Notification = Backbone.Model.extend({
  read: function (options) {
    $.ajax({
      url: 'api/notifications/' + this.get('id')
      , success: function () {
        options.success();
        console.log("notification read")
      }
    })
  }
})
