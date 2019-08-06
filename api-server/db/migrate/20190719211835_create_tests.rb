class CreateTests < ActiveRecord::Migration[6.0]
  def change
    create_table :tests do |t|
      t.string :attack_name, null: false
      t.string :result, null: false

      t.timestamps
    end
  end
end
