Qutria.Models.Question = Backbone.Model.extend({
  urlRoot: "/api/questions"
  , parse: function (resp) {
    if(resp.user) {
      this.user = new Qutria.Models.User(resp.user, { parse : true });
      delete resp.user;
    }
    if(resp.answers) {
      this.answers = new Qutria.Collections.Answers(resp.answers, {
        parse : true
      });
      delete resp.answers;
    }
    if(resp.comments) {
      this.comments = new Qutria.Collections.Comments(resp.comments, {
        parse : true
      });
      delete resp.comments;
    }
    if(resp.tags) {
      this.tags = new Qutria.Collections.Tags(resp.tags, {
        parse : true
      });
      delete resp.tags;
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
        , "type": "Question"}
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
        , "type": "Question"}
      }
      , success: function () {
        self.fetch()
      }
    })
  }
})
