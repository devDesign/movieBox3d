class SeedAliensController < ApplicationController
  

  def create
    require 'open-uri'
    require 'nokogiri'
    user_input = params[:add_movie]
    user_input = user_input.gsub(" ","+")
    @alien = get_movie_info("http://api.themoviedb.org/3/search/movie?api_key=e753e57cc01e48ed3a8d4276010c8092&query=#{user_input}")
    @alien['results'].each do |movie|
      location = "http://api.themoviedb.org/3/movie/#{movie['id']}?api_key=e753e57cc01e48ed3a8d4276010c8092"
      cast_location = "http://api.themoviedb.org/3/movie/#{movie['id']}/credits?api_key=e753e57cc01e48ed3a8d4276010c8092"
      movie_info = Nokogiri::HTML(open(location))
      movie_info_hash = JSON.parse(movie_info)
      movie_cast = Nokogiri::HTML(open(cast_location))
      movie_cast_hash = JSON.parse(movie_cast)
      @movie = Movie.new
      @movie.title = movie['title']
      @movie.poster_image_url = "http://image.tmdb.org/t/p/w300#{movie['poster_path']}"
      @movie.runtime_in_minutes = movie_info_hash['runtime']
      @movie.description = movie_info_hash['overview']
      @movie.release_date = movie_info_hash['release_date']
      @movie.status = movie_info_hash['status']
      @movie.budget = movie_info_hash['budget']
      @movie.tag_line = movie_info_hash['tagline']
      movie_cast_hash['crew'].each do |crew_member|
        if crew_member['job'] == 'Director' 
          @movie.director = crew_member['name']
        end
      end

      @movie.save
    end
    redirect_to '/'

  end

  def get_movie_info(location)
      movie_info = Nokogiri::HTML(open(location))
      JSON.parse(movie_info)
  end
end
