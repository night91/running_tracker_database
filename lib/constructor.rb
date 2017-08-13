require 'mysql2'
require 'sequel'
require 'sequel/extensions/migration'

module RunningTrackerDatabase

  def self.create_models!(db)
    Sequel::MySQL.default_engine = 'InnoDB'
    Sequel::MySQL.default_charset = 'utf8'
    Sequel::Migrator.run(db, File.join(File.dirname(__FILE__), 'migrations'),
                         use_transactions: true, column: :database_version)
  end

  def self.destroy_all!(db)
    Sequel::Migrator.run(db, File.join(File.dirname(__FILE__), 'migrations'),
                         target: 0, column: :database_version)
  end
end