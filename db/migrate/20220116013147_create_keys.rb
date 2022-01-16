class CreateKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :keys do |t|
      t.string :value
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
