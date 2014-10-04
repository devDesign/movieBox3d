class AddReleaseDateToMovies < ActiveRecord::Migration
  def change
    change_column :movies, :release_date, :string
    add_column :movies, :status, :string
    add_column :movies, :budget, :integer
    add_column :movies, :tag_line, :string
    add_column :movies, :imbd, :string
  end
end
