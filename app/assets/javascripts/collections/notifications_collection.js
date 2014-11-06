Qutria.Collections.Notifications = Backbone.Collection.extend({
  url: "/api/notifications"
  , Model: Qutria.Models.Notification
  , parse: function (resp) {
    this.count = resp.count;
    delete resp.count;
    return resp['notifications']
  }
})
