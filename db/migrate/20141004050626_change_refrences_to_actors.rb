class ChangeRefrencesToActors < ActiveRecord::Migration
  def change
      change_table :actors do |t|
      t.references :movies, index: true
    end
  end
end
