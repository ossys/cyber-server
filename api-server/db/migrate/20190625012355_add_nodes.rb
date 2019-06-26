class AddNodes < ActiveRecord::Migration[6.0]
  def change
    create_table :nodes do |t|
      t.references :config, index: true, foreign_key: true

      t.string :key
      t.string :host_identifier
      t.string :platform_type

      t.string :os_platform
      t.string :os_major
      t.string :os_minor
      t.string :os_name
      t.string :os_patch
      t.string :os_version

      t.string :sys_computer_name
      t.string :sys_cpu_brand
      t.string :sys_cpu_logical_cores
      t.string :sys_cpu_microcode
      t.string :sys_cpu_physical_cores
      t.string :sys_cpu_subtype
      t.string :sys_cpu_type
      t.string :sys_hardware_model
      t.string :sys_hostname
      t.string :sys_local_hostname
      t.string :sys_physical_memory
      t.string :sys_uuid

      t.string :osqi_build_distro
      t.string :osqi_build_platform
      t.string :osqi_config_hash
      t.string :osqi_config_valid
      t.string :osqi_extensions
      t.string :osqi_instance_id
      t.string :osqi_pid
      t.string :osqi_start_time
      t.string :osqi_uuid
      t.string :osqi_version
    end
  end
end
