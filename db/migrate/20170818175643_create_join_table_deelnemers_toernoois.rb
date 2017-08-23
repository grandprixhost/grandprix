class CreateJoinTableDeelnemersToernoois < ActiveRecord::Migration[5.1]
  def change
    create_join_table :deelnemers, :toernoois do |t|
      # t.index [:deelnemer_id, :toernooi_id]
      # t.index [:toernooi_id, :deelnemer_id]
    end
  end
end
