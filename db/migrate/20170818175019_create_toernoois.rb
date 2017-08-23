class CreateToernoois < ActiveRecord::Migration[5.1]
  def change
    create_table :toernoois do |t|
      t.string :naam
      t.string :wedstrijdleider
      t.date :datum

      t.timestamps
    end
  end
end
