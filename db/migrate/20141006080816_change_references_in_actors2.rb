class ChangeReferencesInActors2 < ActiveRecord::Migration
  def change
    change_table :actors do |t|
      t.references :movie, index: true
    end
  end
end
