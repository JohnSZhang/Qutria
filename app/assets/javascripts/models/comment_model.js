Qutria.Models.Comment = Backbone.Model.extend({
  urlRoot: "/api/comments"
  , parse: function (resp) {
    if(resp.user) {
      this.user = new Qutria.Models.User(resp.user);
      delete resp.user
    }
    if(resp.comments) {
      this.comments = new Qutria.Collections.Comments(resp.comments, {
        parse : true
      });
      delete resp.comments
    }
    return resp;
  }
})
