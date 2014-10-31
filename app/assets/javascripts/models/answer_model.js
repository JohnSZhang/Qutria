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
, upvote: function () {
  var self = this;
  $.ajax({
    url: "/api/vote"
    , type: "POST"
    , data: {"vote": {
      "id": this.get('id')
      , "type": "Answer"}
    }
    , success: function () {
      self.fetch()
    }
  })
}
, downvote: function () {
  var self = this;
  $.ajax({
    url: "/api/vote"
    , type: "DELETE"
    , data: {"vote": {
      "id": this.get('id')
      , "type": "Answer"}
    }
    , success: function () {
      self.fetch()
    }
  })
}
})
