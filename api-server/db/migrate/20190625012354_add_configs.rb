# frozen_string_literal: true

class AddConfigs < ActiveRecord::Migration[6.0]
  def change
    create_table :configs do |t|
      t.jsonb :data
      t.timestamps
    end
  end
end
