# frozen_string_literal: true

class AddConfigs < ActiveRecord::Migration[6.0]
  def change
    create_table :configs do |t|
      t.string :name, null: false
      t.jsonb :data, null: false
      t.timestamps
    end
  end
end
