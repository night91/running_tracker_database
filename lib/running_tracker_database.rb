require 'securerandom'
require 'running_tracker_database/version'

require_relative '../models/constructor'
require_relative 'data_access/login'
require_relative 'data_access/running_session'
require_relative 'data_access/training_session'
require_relative 'data_access/user'
require_relative 'data_access/user_activity'

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
    SecureRandom.hex(12)
  end
end