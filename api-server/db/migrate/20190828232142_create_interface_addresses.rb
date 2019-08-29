class CreateInterfaceAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :interface_addresses do |t|
      t.string :interface
      t.string :address
      t.string :mask
      t.string :broadcast
      t.string :point_to_point
      t.string :interface_type # type is not an allowed column name

      t.string :unixtime
      t.belongs_to :node
    end
  end
end
