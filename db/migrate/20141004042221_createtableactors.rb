class Createtableactors < ActiveRecord::Migration
  def change
    change_table :actors do |t|
      t.string :full_name
      t.string :role
    end
  end
end
