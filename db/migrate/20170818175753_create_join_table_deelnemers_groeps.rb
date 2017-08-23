class CreateJoinTableDeelnemersGroeps < ActiveRecord::Migration[5.1]
  def change
    create_join_table :deelnemers, :groeps do |t|
      # t.index [:deelnemer_id, :groep_id]
      # t.index [:groep_id, :deelnemer_id]
    end
  end
end
