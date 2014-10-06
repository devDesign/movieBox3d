class AddBackdropToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :backdrop_image_url, :string
  end
end
