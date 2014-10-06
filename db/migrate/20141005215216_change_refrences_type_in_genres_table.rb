class ChangeRefrencesTypeInGenresTable < ActiveRecord::Migration
    def change
    change_table :genres do |t|
      t.references :movie, index: true
    end
  end
end
