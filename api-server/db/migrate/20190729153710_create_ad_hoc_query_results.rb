class CreateAdHocQueryResults < ActiveRecord::Migration[6.0]
  def change
    create_table :ad_hoc_query_results do |t|
      t.belongs_to :node

      t.string :node_key, index: true
      t.jsonb :data

      t.timestamps
    end
  end
end
