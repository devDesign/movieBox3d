class SeedAliensController < ApplicationController
  

  def create
    require 'open-uri'
    require 'nokogiri'
    user_input = params[:add_movie]
    user_input = user_input.gsub(" ","+")
    @alien = get_movie_info("http://api.themoviedb.org/3/search/movie?api_key=e753e57cc01e48ed3a8d4276010c8092&query=#{user_input}")
    @alien['results'].each_with_index do |movie,index|
     
      if movie['poster_path'] != nil && index < 1
      movie_info_target_api = "http://api.themoviedb.org/3/movie/#{movie['id']}?api_key=e753e57cc01e48ed3a8d4276010c8092"
      movie_cast_target_api = "http://api.themoviedb.org/3/movie/#{movie['id']}/credits?api_key=e753e57cc01e48ed3a8d4276010c8092"

      movie_info = Nokogiri::HTML(open(movie_info_target_api))
      movie_info_hash = JSON.parse(movie_info)
      movie_cast = Nokogiri::HTML(open(movie_cast_target_api))
      @movie_cast_hash = JSON.parse(movie_cast)
      @movie = Movie.new
      @movie
      @movie.title = movie['title']
 

      @movie.poster_image_url = "http://image.tmdb.org/t/p/w300#{movie['poster_path']}"
      @movie.runtime_in_minutes = movie_info_hash['runtime']
      @movie.description = movie_info_hash['overview']
      @movie.release_date = movie_info_hash['release_date']
      @movie.status = movie_info_hash['status']
      @movie.budget = movie_info_hash['budget']
      @movie.tag_line = movie_info_hash['tagline']
      @movie.save
      
      movie_info_hash['genres'].each_with_index do |genre|
        @genre = Genre.new
        @genre.movie_id = @movie.id
        @genre.genre = genre['name']
        @genre.save
      end

      @movie_cast_hash['cast'].each_with_index do |cast_member,index|
        if index < 15
            @actor= Actor.new
            actor_picture_target_api = "http://api.themoviedb.org/3/person/#{cast_member['id']}/images?api_key=e753e57cc01e48ed3a8d4276010c8092"
            cast_picture_hash = get_movie_info(actor_picture_target_api)
            actor_picture = cast_picture_hash['profiles']
            actor_picture_path = actor_picture[0]
            if actor_picture_path.class == {}.class
              a = actor_picture_path['file_path'] 
              actor_picture_path['file_path']
              @actor.picture = "https://image.tmdb.org/t/p/w185/#{a}"
            end
            @actor.full_name = cast_member['name']
            @actor.role = cast_member['character']
            @actor.movies_id = @movie.id
            @actor.save
        end
        end
      @movie_cast_hash['crew'].each do |crew_member|
        if crew_member['job'] == 'Director' 
          @movie.director = crew_member['name']
          @movie.save
        end
      end
      end 


    end
    redirect_to '/'

  end

  def get_movie_info(target_api)
    movie_info = Nokogiri::HTML(open(target_api))
    JSON.parse(movie_info)
  end


end
