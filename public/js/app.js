App = Ember.Application.create();

App.Router.map(function() {
  // put your routes here
});

App.IndexRoute = Ember.Route.extend({
  model: function() {
    return $.ajax({
      accepts: {json: 'application/json'},
      cache: false,
      dataType: 'json',
      url: '/api/services'
    })
  }
});
