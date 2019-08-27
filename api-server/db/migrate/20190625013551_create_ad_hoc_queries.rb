# frozen_string_literal: true

class CreateAdHocQueries < ActiveRecord::Migration[6.0]
  def change
    create_table :ad_hoc_queries do |t|
      t.boolean :completed, default: false
      t.boolean :timed_out, default: false
      t.timestamps
    end

    create_table :queries do |t|
      t.text :name, null: false
      t.text :body, null: false
      t.timestamps
    end

    create_join_table(:ad_hoc_queries, :queries) do |t|
      t.index :ad_hoc_query_id
      t.index :query_id
    end

    create_join_table(:ad_hoc_queries, :nodes) do |t|
      t.index :ad_hoc_query_id
      t.index :node_id
    end
  end
end
