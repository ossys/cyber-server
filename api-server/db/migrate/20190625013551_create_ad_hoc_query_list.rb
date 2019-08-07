# frozen_string_literal: true

class CreateAdHocQueryList < ActiveRecord::Migration[6.0]
  def change
    create_table :ad_hoc_query_lists do |t|
      t.boolean :has_run, default: false
      t.timestamps
    end

    create_table :queries do |t|
      t.text :name, null: false
      t.text :body, null: false
      t.timestamps
    end

    create_join_table(:ad_hoc_query_lists, :queries) do |t|
      t.index :ad_hoc_query_list_id
      t.index :query_id
    end

    create_join_table(:ad_hoc_query_lists, :nodes) do |t|
      t.index :ad_hoc_query_list_id
      t.index :node_id
    end
  end
end
