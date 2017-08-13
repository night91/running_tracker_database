require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :db do
  desc 'Run database migrations'
  task :migrations do
  	require 'colorize'
    require 'highline'
    require './lib/running_tracker_database'

    begin
      cli = HighLine.new
      convert = -> (str) { str =~ /^y$/i }
      message = "Are you trying to run migrations for the running tracker database ? (y / n)"
      agree = cli.ask(message, convert) { |q| q.validate = /^(y|n)$/i }

      if agree
      	endpoint = cli.ask('Endpoint: ') { |q| q.default = "mysql2://root:root@localhost/running_tracker" }

        puts 'Connecting...'.blue
        db = RunningTrackerDatabase.connect({ 'endpoint' => endpoint, 'max_connections' => 1 })

        puts 'Running migrations...'.blue
        RunningTrackerDatabase.create_models!(db)

        puts 'Done!!'.green
        puts "Schema version number is: #{db[:schema_info].first[:database_version]}"
      else
        puts 'Bye'.green
      end
    rescue => e
      puts "ERROR: #{e.inspect}".red
      puts "In: #{e.backtrace.join("\n    ")}"
    end
  end
end
