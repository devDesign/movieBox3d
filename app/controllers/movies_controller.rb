class MoviesController < ApplicationController

  def index
    @movies = Movie.all
    @movies = Movie.search(params[:search]) unless params[:search].blank?
    @movies = Movie.search_director(params[:search_director]) unless params[:search_director].blank?
    @movies = Movie.search_runtime(params[:search_runtime]) unless params[:search_runtime].blank?
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def seed
  value = '{
        "id": "13240",
        "title": "Aliens",
        "year": 1986,
        "mpaa_rating": "R",
        "runtime": 138,
        "critics_consensus": "",
        "release_dates": {
            "theater": "1986-07-18",
            "dvd": "1999-06-01"
        },
        "ratings": {
            "critics_rating": "Certified Fresh",
            "critics_score": 98,
            "audience_rating": "Upright",
            "audience_score": 94
        },
        "synopsis": "",
        "posters": {
            "thumbnail": "http://content6.flixster.com/movie/11/18/07/11180796_tmb.jpg",
            "profile": "http://content6.flixster.com/movie/11/18/07/11180796_tmb.jpg",
            "detailed": "http://content6.flixster.com/movie/11/18/07/11180796_tmb.jpg",
            "original": "http://content6.flixster.com/movie/11/18/07/11180796_tmb.jpg"
        },
        "abridged_cast": [{
            "name": "Sigourney Weaver",
            "id": "162660903",
            "characters": ["Ellen Ripley"]
        }, {
            "name": "Carrie Henn",
            "id": "326298076",
            "characters": ["Newt"]
        }, {
            "name": "Michael Biehn",
            "id": "162681092",
            "characters": ["Cpl. Dwayne Hicks"]
        }, {
            "name": "Lance Henriksen",
            "id": "162660194",
            "characters": ["Bishop"]
        }, {
            "name": "Paul Reiser",
            "id": "162654031",
            "characters": ["Carter Burke"]
        }],
        "alternate_ids": {
            "imdb": "0090605"
        },
        "links": {
            "self": "http://api.rottentomatoes.com/api/public/v1.0/movies/13240.json",
            "alternate": "http://www.rottentomatoes.com/m/1000617-aliens/",
            "cast": "http://api.rottentomatoes.com/api/public/v1.0/movies/13240/cast.json",
            "reviews": "http://api.rottentomatoes.com/api/public/v1.0/movies/13240/reviews.json",
            "similar": "http://api.rottentomatoes.com/api/public/v1.0/movies/13240/similar.json"
        }
    }'
  @alien = JSON.parse(value)
  binding.pry
    @alien.each do |movie|
      @movie = Movie.new
      @movie.title = movie[:title]
    end

  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :image, :description
    )
  end

end