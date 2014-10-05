class ChangeRefrencesTypeInGenres < ActiveRecord::Migration
  def change
    change_table :genres do |t|
      t.references :movies, index: true
    end
  end
end
