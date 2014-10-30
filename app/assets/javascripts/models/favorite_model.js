Qutria.Models.Favorite = Backbone.Model.extend({
  urlRoot: "/api/favorite"
  , parse: function (resp) {
    if(resp.user) {
      this.user = new Qutria.Models.User(
        resp.user
        , { parse: true } );
      delete resp.user;
    }
    if(resp.favorite_tags) {
      this.favorite_tags = new Qutria.Collections.Tags(
        resp.favorite_tags
        , { parse: true } );
      delete resp.favorite_tags;
    }
    if(resp.favorite_tag_questions) {
      this.favorite_tag_questions = new Qutria.Collections.Questions(
        resp.favorite_tag_questions
        , { parse: true } );
      delete resp.favorite_tag_questions;
    }
    return resp;
  }
})
