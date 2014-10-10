$('.local_movies').on("click",function(){
  getLocation();
});


function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.watchPosition(showPosition);
    } else {
        x.innerHTML = "Geolocation is not supported by this browser.";
    }
}
function showPosition(position){
  var lat = position.coords.latitude;
  var lon = position.coords.longitude;
  var local_movies = {};

  getmovies(lat,lon);
}

function postaliens(data, textStatus, xhr){
  $.each(data,function(index,movie){
    $.post('/seed_aliens?add_movie='+movie['title']+'&number_of_results=1')
  });
}

function getmovies(lat,lon){
  var date = moment().format().substring(0,10)

  $.ajax({
    url: 'http://data.tmsapi.com/v1/movies/showings?startDate='+date+'&lat='+lat+'&lng='+lon+'&api_key=myamgz52pwncbm2stvy89s9v',
    type: 'GET',
    dataType: 'json',
    success: function(data){
      postaliens(data);
      }

  });
}