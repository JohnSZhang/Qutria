Qutria.Collections.Notifications = Backbone.Collection.extend({
  url: "/api/notifications"
  , Model: Qutria.Models.Notification
  , parse: function (resp) {
    this.notification_count = resp.notification_count;
    delete resp.notification_count;
    return resp['notifications']
  }
})
