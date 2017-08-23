class CreatePartijs < ActiveRecord::Migration[5.1]
  def change
    create_table :partijs do |t|
      t.string :uitslag

      t.timestamps
    end
  end
end
