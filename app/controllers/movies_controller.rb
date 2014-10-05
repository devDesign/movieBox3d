class MoviesController < ApplicationController

  def index
    @genre = Genre.all
    @movies = Movie.all
    @movies = Movie.search(params[:search]) unless params[:search].blank?
    @movies = Movie.search_director(params[:search_director]) unless params[:search_director].blank?
    @movies = Movie.search_runtime(params[:search_runtime]) unless params[:search_runtime].blank?
  end

  def show
    movie_id = params[:id]
    @movie = Movie.find(movie_id)
    @actors = Actor.where(movies_id: movie_id)
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