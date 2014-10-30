Qutria.Models.Answer = Backbone.Model.extend({
  urlRoot: "/api/answers"
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