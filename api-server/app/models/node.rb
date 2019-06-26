# frozen_string_literal: true

require 'securerandom'

class Node < ApplicationRecord
  belongs_to :config

  def set_fields(params)
    details = params['host_details']
    os_version = details['os_version']
    osquery_info = details['osquery_info']
    system_info = details['system_info']

    self.key = Node.generate_key
    self.host_identifier = params['host_identifier']
    self.platform_type = params['platform_type']

    self.os_platform = os_version['platform']
    self.os_major    = os_version['major']
    self.os_minor    = os_version['minor']
    self.os_name     = os_version['name']
    self.os_patch    = os_version['patch']
    self.os_version  = os_version['version']

    self.sys_computer_name      = system_info['computer_name']
    self.sys_cpu_brand          = system_info['cpu_brand'].gsub(/\u0000/, '')
    self.sys_cpu_logical_cores  = system_info['cpu_logical_cores']
    self.sys_cpu_microcode      = system_info['cpu_microcode']
    self.sys_cpu_physical_cores = system_info['cpu_physical_cores']
    self.sys_cpu_subtype        = system_info['cpu_subtype']
    self.sys_cpu_type           = system_info['cpu_type']
    self.sys_hardware_model     = system_info['hardware_model']
    self.sys_hostname           = system_info['hostname']
    self.sys_local_hostname     = system_info['local_hostname']
    self.sys_physical_memory    = system_info['physical_memory']
    self.sys_uuid               = system_info['uuid']

    self.osqi_build_distro   = osquery_info['build_distro']
    self.osqi_build_platform = osquery_info['build_platform']
    self.osqi_config_hash    = osquery_info['config_hash']
    self.osqi_config_valid   = osquery_info['config_valid']
    self.osqi_extensions     = osquery_info['extensions']
    self.osqi_instance_id    = osquery_info['instance_id']
    self.osqi_pid            = osquery_info['pid']
    self.osqi_start_time     = osquery_info['start_time']
    self.osqi_uuid           = osquery_info['uuid']
    self.osqi_version        = osquery_info['version']
  end

  def self.generate_key
    SecureRandom.uuid
  end
end
