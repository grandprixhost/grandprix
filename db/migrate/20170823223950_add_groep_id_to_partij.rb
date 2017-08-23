class AddGroepIdToPartij < ActiveRecord::Migration[5.1]
  def change
    add_column :partijs, :groep_id, :int
  end
end
