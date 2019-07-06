# frozen_string_literal: true

# spec/integration/blogs_spec.rb
require 'swagger_helper'

describe 'OsQuery Remote API' do
  path '/enroll' do
    post 'enrolls successfully' do
      tags 'OsQuery'
      consumes 'application/json'
      parameter name: :data, in: :body, schema: { type: :object }

      response '200', 'success enroll' do
        let (:data) {
            {"enroll_secret"=>ENV['OSQUERY_ENROLL_SECRET'], "host_identifier"=>"squanch", "platform_type"=>"9", "host_details"=>{"os_version"=>{"_id"=>"9", "major"=>"9", "minor"=>"0", "name"=>"Debian GNU/Linux", "patch"=>"0", "platform"=>"debian", "version"=>"9 (stretch)"}, "osquery_info"=>{"build_distro"=>"xenial", "build_platform"=>"ubuntu", "config_hash"=>"", "config_valid"=>"0", "extensions"=>"inactive", "instance_id"=>"f3814402-9893-43e1-b98c-fdc10b4e833e", "pid"=>"23356", "start_time"=>"1561504969", "uuid"=>"91c0f9a6-b200-4fdc-be36-09f8b852f3bf", "version"=>"3.3.2", "watcher"=>"1"}, "system_info"=>{"computer_name"=>"squanch", "cpu_brand"=>"Intel(R) Core(TM) i7-5820K CPU @ 3.30GHz\u0000\u0000\u0000\u0000", "cpu_logical_cores"=>"12", "cpu_microcode"=>"0x29", "cpu_physical_cores"=>"6", "cpu_subtype"=>"63", "cpu_type"=>"x86_64", "hardware_model"=>"", "hostname"=>"squanch.zah.local", "local_hostname"=>"squanch.zah.local", "physical_memory"=>"16752640000", "uuid"=>"91c0f9a6-b200-4fdc-be36-09f8b852f3bf"}}}
        }

        run_test!
      end

      response '200', 'invalid secret' do
        let (:data) {
            {"enroll_secret"=>'incorrect_secret', "host_identifier"=>"squanch", "platform_type"=>"9", "host_details"=>{"os_version"=>{"_id"=>"9", "major"=>"9", "minor"=>"0", "name"=>"Debian GNU/Linux", "patch"=>"0", "platform"=>"debian", "version"=>"9 (stretch)"}, "osquery_info"=>{"build_distro"=>"xenial", "build_platform"=>"ubuntu", "config_hash"=>"", "config_valid"=>"0", "extensions"=>"inactive", "instance_id"=>"f3814402-9893-43e1-b98c-fdc10b4e833e", "pid"=>"23356", "start_time"=>"1561504969", "uuid"=>"91c0f9a6-b200-4fdc-be36-09f8b852f3bf", "version"=>"3.3.2", "watcher"=>"1"}, "system_info"=>{"computer_name"=>"squanch", "cpu_brand"=>"Intel(R) Core(TM) i7-5820K CPU @ 3.30GHz\u0000\u0000\u0000\u0000", "cpu_logical_cores"=>"12", "cpu_microcode"=>"0x29", "cpu_physical_cores"=>"6", "cpu_subtype"=>"63", "cpu_type"=>"x86_64", "hardware_model"=>"", "hostname"=>"squanch.zah.local", "local_hostname"=>"squanch.zah.local", "physical_memory"=>"16752640000", "uuid"=>"91c0f9a6-b200-4fdc-be36-09f8b852f3bf"}}}
        }

        run_test!
      end

      response '200', 'missing data' do
        let (:data) {
            {"enroll_secret"=>'very_secret'}
        }

        run_test!
      end
    end
  end
end
