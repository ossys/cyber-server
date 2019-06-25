class AddConfigs < ActiveRecord::Migration[6.0]
  def change
    create_table :configs do |t|
      t.jsonb :data
      t.references :node, foreign_key: true
      t.timestamps
    end
  end
end
