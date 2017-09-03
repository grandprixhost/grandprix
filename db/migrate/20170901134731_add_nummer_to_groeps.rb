class AddNummerToGroeps < ActiveRecord::Migration[5.1]
  def change
    add_column :groeps, :nummer, :integer
  end
end
