require 'securerandom'
require 'running_tracker_database/version'
require './models/constructor'

# Kueski Database module
module RunningTrackerDatabase
  def self.connect(settings)
    database = Sequel.connect(
      settings['endpoint'],
      max_connections: settings['max_connections'],
      servers: settings['servers'] || {}
    )
    database.extension :date_arithmetic
  end

  def self.generate_unique_id
    SecureRandom.hex(24)
  end
end