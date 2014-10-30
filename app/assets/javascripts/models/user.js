Qutria.Models.User = Backbone.Model.extend({
  urlRoot: 'api/users'
  , parse: function (resp) {
    if(resp.favorite_tags) {
      this.favorite_tags = new Qutria.Collection.Tags(
        resp.favorite_tags
        , { parse: true } );
      delete resp.favorite_tags;
    }
    if(resp.favorite_tag_questions) {
      this.favorite_tag_questions = new Qutria.Collection.Questions(
        resp.favorite_tag_questions
        , { parse: true } );
      delete resp.favorite_tag_questions;
    }
    return resp;
  }
});
