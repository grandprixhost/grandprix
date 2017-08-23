class CreateDeelnemers < ActiveRecord::Migration[5.1]
  def change
    create_table :deelnemers do |t|
      t.string :voornaam
      t.string :achternaam
      t.string :tussenvoegsel
      t.date :geboortedatum

      t.timestamps
    end
  end
end
