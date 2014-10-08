class MoviesController < ApplicationController

  def index
    @movies = Movie.all
    search_filters()
  end

  def show
    movie_id = params[:id]
    @movie = Movie.find(movie_id)
    @actors = Actor.where(movie_id: movie_id)
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

  def search_filters
    @movies = Movie.search_genre(params[:search_genre]) unless params[:search_genre].blank?

    @movies = Movie.search_action(params[:search_action]) unless params[:search_action].blank?
    @movies = Movie.search_comedy(params[:search_comedy]) unless params[:search_comedy].blank?
    @movies = Movie.search_adventure(params[:search_adventure]) unless params[:search_adventure].blank?
    @movies = Movie.search_animation(params[:search_animation]) unless params[:search_animation].blank?
    @movies = Movie.search_crime(params[:search_crime]) unless params[:search_crime].blank?
    @movies = Movie.search_documentary(params[:search_documentary]) unless params[:search_documentary].blank?
    @movies = Movie.search_drama(params[:search_drama]) unless params[:search_drama].blank?
    @movies = Movie.search_family(params[:search_family]) unless params[:search_family].blank?
    @movies = Movie.search_fantasy(params[:search_fantasy]) unless params[:search_fantasy].blank?
    @movies = Movie.search_foreign(params[:search_foreign]) unless params[:search_foreign].blank?
    @movies = Movie.search_history(params[:search_history]) unless params[:search_history].blank?
    @movies = Movie.search_horror(params[:search_horror]) unless params[:search_horror].blank?
    @movies = Movie.search_music(params[:search_music]) unless params[:search_music].blank?
    @movies = Movie.search_mystery(params[:search_mystery]) unless params[:search_mystery].blank?
    @movies = Movie.search_romance(params[:search_romance]) unless params[:search_romance].blank?
    @movies = Movie.search_thriller(params[:search_thriller]) unless params[:search_thriller].blank?
    @movies = Movie.search_war(params[:search_war]) unless params[:search_war].blank?
    @movies = Movie.search_western(params[:search_western]) unless params[:search_western].blank?

    @movies = Movie.search(params[:search]) unless params[:search].blank?
    @movies = Movie.search_runtime(params[:search_runtime]) unless params[:search_runtime].blank?
    @movies = Movie.search_actor(params[:search_actor]) unless params[:search_actor].blank?


  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :image, :description
    )
  end

end