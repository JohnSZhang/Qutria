Qutria.Collections.Questions = Backbone.Collection.extend({
  url: "/api/questions"
  , Model: Qutria.Models.Question
  , parse: function (resp) {
    this.max_pages = resp['pages'];
    delete resp['pages']
    return resp['questions']
  }
})
