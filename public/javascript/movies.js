var x = document.getElementById("title");
$('#showtimes-link').on("click",function(){
  $(this).fadeOut("slow","linear");
  getLocation();
});
function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.watchPosition(showPosition);
    } else {
        x.innerHTML = "Geolocation is not supported by this browser.";
    }
}
function showPosition(position) {
  var lat = position.coords.latitude;
  var lon = position.coords.longitude;
  var local_movies = {};

  displayShowtimes(lat,lon);
}
function displayShowtimes(lat,lon){
  var date = moment().format().substring(0,10)

  $.ajax({
    url: 'http://data.tmsapi.com/v1/movies/showings?startDate='+date+'&lat='+lat+'&lng='+lon+'&api_key=myamgz52pwncbm2stvy89s9v',
    type: 'GET',
    dataType: 'json',
    success: function(data, textStatus, xhr){
       
      $.each(data,function(index,movie){
        if (movie['title'] == $('.title').text()){
          $.each(movie['showtimes'],function(index,showtime){
            var theatreName = showtime['theatre']['name'];
            var theatreShowtime = showtime['dateTime'];
            var hour = theatreShowtime.substring(11,13);
            var now = moment().format().substring(11,13);
            $.each($('#theatre').children(),function(index,movie_theatre){
              if (movie_theatre.id == showtime['theatre']['id']){
                console.log(showtime['dateTime']);
                
                if (hour>now){  
                $('<div/>', {
                rel: 'external',
                text: moment(theatreShowtime).format("MMMM Do YYYY, h:mm:ss a")
                }).appendTo($("#"+showtime['theatre']['id']));}
              } else if(movie_theatre.id == "free" && hour>now) {
                $('<div/>', {
                id: showtime['theatre']['id'],
                title: theatreName,
                rel: 'external',
                html: "<h2>"+theatreName+"</h2>"+moment(theatreShowtime).format("MMMM Do YYYY, h:mm:ss a")
                }).appendTo($('#theatre'));
                movie_theatre.id = "locked";
              }
            });

            
          });
        }
      });
    return false;}
  });
}
