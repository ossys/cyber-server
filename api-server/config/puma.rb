# frozen_string_literal: true

gauntlt_port = ENV.fetch('GAUNTLT_PORT') { 5000 }

max_threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
min_threads_count = ENV.fetch('RAILS_MIN_THREADS') { max_threads_count }
threads min_threads_count, max_threads_count

port gauntlt_port

environment ENV.fetch('RACK_ENV') { 'development' }

app_dir = File.expand_path('..', __dir__)
tmp_dir = File.join(app_dir, 'tmp')
log_dir = File.join(app_dir, 'log')

bind "unix://#{tmp_dir}/sockets/puma.sock"
ssl_bind '127.0.0.1', '5001', {
  cert: File.join('app', 'assets', 'server.crt'),
  key: File.join('app', 'assets', 'server.key')
}

# logging
# stdout_redirect "#{tmp_dir}/log/puma.stdout.log", "#{tmp_dir}/log/puma.stderr.log", true

pidfile "#{tmp_dir}/pids/puma.pid"
state_path "#{tmp_dir}/pids/puma.state"
# activate_control_app

plugin :tmp_restart
