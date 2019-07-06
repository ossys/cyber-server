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

    create_table :ad_hoc_query_lists_queries do |t|
      t.belongs_to :ad_hoc_query_list, index: true
      t.belongs_to :query, index: true
    end
  end
end
