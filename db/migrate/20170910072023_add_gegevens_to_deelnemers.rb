class AddGegevensToDeelnemers < ActiveRecord::Migration[5.1]
  def change
    add_column :deelnemers, :email, :string
    add_column :deelnemers, :telefoonnummer, :string
    add_column :deelnemers, :knsbnummer, :integer
    add_column :deelnemers, :rating, :integer
  end
end
