class AddZwartspelerIdToPartijs < ActiveRecord::Migration[5.1]
  def change
    add_column :partijs, :zwartspeler_id, :integer
  end
end
