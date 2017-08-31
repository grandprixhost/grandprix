class AddWitspelerIdToPartijs < ActiveRecord::Migration[5.1]
  def change
    add_column :partijs, :witspeler_id, :integer
  end
end
