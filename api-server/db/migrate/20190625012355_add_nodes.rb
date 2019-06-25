class AddNodes < ActiveRecord::Migration[6.0]
  def change
    create_table :nodes do |t|
      t.string :node_key
      t.string :host_identifier
      t.string :os_version
      t.string :osquery_info
      t.string :system_info
      t.string :platform_info
    end
  end
end
