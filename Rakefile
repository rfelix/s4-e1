require 'rspec/core/rake_task'

namespace :spec do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.name = "all"
  end

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.name = "unit"
    t.rspec_opts = "--tag ~@acceptance"
  end

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.name = "acceptance"
    t.rspec_opts = "--tag @acceptance"
  end
end

task :default => "spec:all"
