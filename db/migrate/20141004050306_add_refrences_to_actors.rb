class AddRefrencesToActors < ActiveRecord::Migration
  def change
    change_table :actors do |t|
      t.references :user, index: true
    end
  end
end
