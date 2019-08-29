class CreateUsbLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :usb_logs do |t|
      t.string :action
      t.string :subclass
      t.string :model
      t.string :model_id
      t.string :protocol
      t.string :removable
      t.string :serial
      t.string :usb_class # no column can be named class
      t.string :usb_port
      t.string :usb_address
      t.string :vendor
      t.string :vendor_id
      t.string :version

      t.string :unixtime
      t.belongs_to :node
    end
  end
end
