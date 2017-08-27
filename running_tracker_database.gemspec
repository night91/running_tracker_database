# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "running_tracker_database/version"

Gem::Specification.new do |spec|
  spec.name          = "running_tracker_database"
  spec.version       = RunningTrackerDatabase::VERSION
  spec.authors       = ["Eddy Roberto Morales Perez"]
  spec.email         = ["eddyr.morales@gmail.com"]

  spec.summary       = "Create the database models for the running tracker app"
  spec.description   = "Create the database models for the running tracker app and configure the connection"
  spec.homepage      = "https://github.com/night91/running_tracker_database"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "sequel", "~> 4.47.0"
  spec.add_runtime_dependency "mysql", "~> 2.9"
  spec.add_runtime_dependency "mysql2", "~> 0.4"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "highline", "~> 1.7"
  spec.add_development_dependency "colorize", "~> 0.8"
end
