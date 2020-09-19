# frozen_string_literal: true

require 'webdrivers'
load 'webdrivers/Rakefile'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)

  task default: :spec
rescue LoadError # rubocop:disable Lint/SuppressedException
end
