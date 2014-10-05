class CreateGenresTable < ActiveRecord::Migration
  def change
    create_table :genres_tables do |t|
      t.references :movies
    end
  end
end
