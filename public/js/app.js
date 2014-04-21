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
    }).done(function(services) {
      $.each(services, function(id,service) {
        // get number of raid_engenio1 checks
        service["priority"] = service["allevents"].filter(function(obj) { 
          return (obj.check === "raid_engenio1");
        }).length;
        console.log(service["priority"]);
      });
    });
  }
});
