class AddToernooiIdToGroep < ActiveRecord::Migration[5.1]
  def change
    add_column :groeps, :toernooi_id, :int
  end
end
